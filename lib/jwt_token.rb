# frozen_string_literal: true

require 'jwt'

##
# = Encoding JWT
#
# To encode, call the static method JWTToken.encode()
# Example of encoding JWT
#
#   token = JWTToken.encode(%{ uid: 123456789 }, expiry: 24.hours.from_now)
#
# = Decoding JWT
#
# To decode, first initialise JWTToken by passing in the string containing the
# token. Then, invoke the method decode which will either return true or false
# depending on the success of decode.
# If it does not succeed in decoding, the error message as a string is put in
# the attribute error.
# Example of decoding JWT
#
#   def decode_jwt(authorization_bearer_token)
#     token = JWTToken.new(authorization_bearer_token)
#     if token.decode
#       token.payload
#     else
#       render json: { error: token.error }
#       return
#     end
#   end
class JWTToken
  ALGORITHM = 'HS256'

  attr_reader :payload, :error

  def initialize(token)
    @token = token
  end

  def decode
    payload, _header = JWT.decode(@token, key, true)
    @payload = payload
    true
  rescue JWT::ExpiredSignature
    @error = 'Token expired'
    false
  rescue JWT::DecodeError
    @error = 'Invalid token'
    false
  end

  def self.encode(payload, opts)
    payload[:exp] = opts[:expiry].to_i
    JWT.encode(payload, key, ALGORITHM)
  end

  private

  def key
    ENV['KEY'] || Rails.application.secrets.secret_key_base
  end
end
