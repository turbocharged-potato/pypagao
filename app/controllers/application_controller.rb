# frozen_string_literal: true

class ApplicationController < ActionController::API
  attr_reader :current_user

  before_action :authenticate

  AUTH_ERROR_MESSAGES = { expired: 'Token expired', invalid: 'Invalid token',
                          missing: 'Missing token' }.freeze

  def authenticate
    token = jwt
    render_unauthorized(:missing) && return unless token
    payload, error = Auth.decode(token).values_at(:payload, :error)
    render_unauthorized(error) && return unless token
    process_payload(payload)
  end

  def render_unauthorized(reason)
    error = AUTH_ERROR_MESSAGES[reason] || reason
    render json: { error: error }, status: :unauthorized
  end

  private

  def process_payload(payload)
    user = User.find(payload[:uid])
    render_unauthorized(:invalid) && return unless user
    @current_user = user
  end

  def jwt
    authorization_header.last if valid_authorization_header?
  end

  def valid_authorization_header?
    header = authorization_header
    header.first == 'Bearer' && header.count == 2
  end

  def authorization_header
    request.headers['Authorization'].split(' ').presence
  end
end
