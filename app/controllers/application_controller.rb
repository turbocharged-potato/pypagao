# frozen_string_literal: true

class ApplicationController < ActionController::API
  attr_reader :current_user

  before_action :authenticate

  def authenticate
    return unless (jwt_header = jwt_authorization_header)
    token = JWTToken.new(jwt_header)
    render_error(token.error, :unauthorized) && return unless token.decode
    user = User.find_by(id: token.payload[:uid])
    render_error('Invalid token', :unauthorized) && return unless user
    @current_user = user
  end

  def render_error(reason, status)
    render_json({ error: reason || '' }, status)
  end

  def render_json(body, status)
    render json: body, status: status
  end

  def ensure_params_fields(fields)
    all_present = fields.reduce(true) do |acc, field|
      params[field].present? && acc
    end
    unless all_present
      render_error('Missing parameter', :unprocessable_entity)
      return
    end
    true
  end

  private

  def jwt_authorization_header
    unless valid_authorization_header?
      render_error('Missing/Invalid Authorization header', :unauthorized)
      return
    end
    authorization_header.last
  end

  def valid_authorization_header?
    header = authorization_header
    header && header.first == 'Bearer' && header.count == 2
  end

  def authorization_header
    request&.headers&.[]('Authorization')&.split(' ')&.presence
  end
end
