# frozen_string_literal: true

require 'jwt'

class JWTAuth
  ALGORITHM = 'HS256'

  class << self
    def issue(payload, expiry = 24.hours.from_now)
      payload[:exp] = expiry.to_i
      JWT.encode(payload, key, ALGORITHM)
    end

    def decode(token)
      payload, _header = JWT.decode(token, key, true, algorithm: ALGORITHM)
      { payload: HashWithIndifferentAccess.new(payload), error: nil }
    rescue JWT::ExpiredSignature
      { payload: nil, error: :expired }
    rescue JWT::DecodeError
      { payload: nil, error: :invalid }
    end

    private

    def key
      ENV['KEY'] || Rails.application.secrets.secret_key_base
    end
  end
end
