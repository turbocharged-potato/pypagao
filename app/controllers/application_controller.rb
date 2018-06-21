# frozen_string_literal: true

class ApplicationController < ActionController::API
  attr_reader :current_user

  before_action :authenticate

  def authenticate
    return unless (jwt = jwt_authorization_header)
    token = JWTToken.new(jwt)
    render_unauthorized(token.error) && return unless token.decode
    user = User.find(token.payload[:uid])
    render_unauthorized('Invalid token') && return unless user
    @current_user = user
  end

  def render_unauthorized(reason)
    reason ||= ''
    render json: { error: reason }, status: :unauthorized
  end

  private

  def process_payload(payload)
    user = User.find(payload[:uid])
    render_unauthorized(:invalid) && return unless user
    @current_user = user
  end

  def jwt_authorization_header
    unless valid_authorization_header?
      render_unauthorized('Missing/Invalid Authorization header')
      return
    end
    authorization_header.last
  end

  def valid_authorization_header?
    header = authorization_header
    header.first == 'Bearer' && header.count == 2
  end

  def authorization_header
    request.headers['Authorization'].split(' ').presence
  end
end
