# frozen_string_literal: true

module AuthHelper
  def sign_in(user)
    access_token = JWTToken.encode(uid: user.id)
    request.headers.merge!('Authorization' => "Bearer #{access_token}")
  end
end
