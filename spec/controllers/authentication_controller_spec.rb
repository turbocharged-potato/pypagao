# frozen_string_literal: true

require 'jwt_token'
require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  before do
    @request.env['HTTP_ACCEPT'] = 'application/json'
    @request.env['CONTENT_TYPE'] = 'application/json'
  end

  describe 'POST #login' do
    it 'should gives token to valid users' do
      user = create(:user)
      post :login, params: { email: user.email, password: user.password }
      should respond_with :ok
      expect(JSON.parse(response.body)).to have_key('token')
    end

    it 'should return 401 for invalid users' do
      post :login, params: { email: 'anu', password: 'asu' }
      should respond_with :unauthorized
      expect(JSON.parse(response.body)['error']).to eq('Wrong credentials')
    end

    it 'should return 422 for missing parameter(s)' do
      post :login, params: { email: 'anu' }
      should respond_with :unprocessable_entity
      expect(JSON.parse(response.body)['error']).to eq('Missing parameter')
    end
  end
end
