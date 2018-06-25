# frozen_string_literal: true

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

  describe 'POST #register' do
    it 'should proceed given valid user information' do
      university = create(:university)
      user = build(:user, university: university)
      post :register, params: { email: user.email, name: user.name,
                                password: user.password,
                                university_id: university.id }
      should respond_with :ok
      expect(response.body).to eq('')
    end

    it 'should return 422 for missing parameter(s)' do
      post :register
      should respond_with :unprocessable_entity
      expect(JSON.parse(response.body)['error']).to eq('Missing parameter')
    end

    it 'should return 400 for duplicate email' do
      user = create(:user)
      post :register, params: { email: user.email, name: user.name,
                                password: user.password,
                                university_id: user.university.id }
      should respond_with :bad_request
      expect(JSON.parse(response.body)['error'])
        .to eq('Email has already been taken')
    end
  end

  describe 'GET #verify' do
    it 'should verify valid user' do
      user = create(:user)
      get :verify, params: { token: user.token }
      should respond_with :ok
      expect(response.body).to eq('')
      expect(User.find_by(id: user.id).verified).to eq(true)
    end

    it 'should return 422 for missing token' do
      get :verify
      should respond_with :unprocessable_entity
      expect(JSON.parse(response.body)['error']).to eq('Missing token')
    end

    it 'should response 400 for invalid token' do
      get :verify, params: { token: 'asd' }
      should respond_with :bad_request
      expect(JSON.parse(response.body)['error'])
        .to eq('Invalid verification token')
    end

    it 'should reject already verified user' do
      user = create(:user, verified: true)
      get :verify, params: { token: user.token }
      should respond_with :bad_request
      expect(JSON.parse(response.body)['error']).to eq('Already verified')
    end

    it 'sends 500 when error saving' do
      user = create(:user)
      allow(User).to receive(:find_by).with(token: user.token).and_return(user)
      allow(user).to receive(:update).and_return(false)
      get :verify, params: { token: user.token }
      should respond_with :internal_server_error
      expect(JSON.parse(response.body)['error']).to eq('Error saving')
    end
  end
end
