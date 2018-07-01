# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate

  def login
    return unless ensure_params_fields(%i[email password])
    user = User.find_by(email: login_params[:email].downcase)
    if user&.authenticate(login_params[:password])
      return unless ensure_verified(user)
      render_json({ accessToken: JWTToken.encode(uid: user.id),
                    name: user.name }, :ok)
    else
      render_error('Wrong credentials', :unauthorized)
    end
  end

  def register
    return unless ensure_params_fields(%i[email name password university_id])
    user = User.new register_params
    if user.save
      RegistrationMailer.registration(user).deliver_later
      render_json('', :ok)
    else
      render_error(user.errors.full_messages.join(', '), :bad_request)
    end
  end

  def verify
    unless params[:token]
      render_error('Missing token', :unprocessable_entity) && return
    end
    user = User.find_by(token: params[:token])
    return unless check_eligible_for_verified_status(user)
    if user.update(verified: true)
      render_json('', :ok)
    else
      render_error('Error saving', :internal_server_error)
    end
  end

  private

  def check_eligible_for_verified_status(user)
    unless user
      render_error('Invalid verification token', :bad_request) && return
    end
    render_error('Already verified', :bad_request) && return if user.verified
    true
  end

  # Pre-condition: user is not nil
  def ensure_verified(user)
    unless user.verified
      render_error('User is not verified', :bad_request) && return
    end
    true
  end

  def login_params
    params.require(:authentication).permit(:email, :password)
  end

  def register_params
    params.require(:authentication).permit(:email, :name, :password,
                                           :university_id)
  end
end
