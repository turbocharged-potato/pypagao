# frozen_string_literal: true

require 'jwt_token'

class AuthenticationController < ApplicationController
  skip_before_action :authenticate, only: [:login]

  def login
    return unless ensure_params_fields(%i[email password])
    user = User.find_by(email: params[:email].downcase)
    if user&.authenticate(params[:password])
      render_json({ token: JWTToken.encode(uid: user.id) }, :ok)
    else
      render_error('Wrong credentials', :unauthorized)
    end
  end

  def check
    render json: {}
  end
end
