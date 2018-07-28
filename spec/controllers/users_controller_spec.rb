# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    @university = create(:university)
    @user = create(:user, university: @university)
  end

  describe 'GET #index' do
    before do
      sign_in(@user)
    end

    it 'should lists all users' do
      get :index
      should respond_with :ok
      expect(JSON.parse(response.body))
        .to eql([user_hash(@user).with_indifferent_access])
    end

    it 'should lists users from a certain university' do
      get :index, params: { university_id: @university.id }
      should respond_with :ok
      expect(JSON.parse(response.body))
        .to eql([user_hash(@user).with_indifferent_access])
    end

    it 'should search for user name' do
      username = 'Tiffany'
      user = create(:user, name: username)
      get :index, params: { name: username }
      expect(JSON.parse(response.body))
        .to eql([user_hash(user).with_indifferent_access])
    end
  end

  describe 'GET #index if signed out' do
    it 'should not list any users if signed out' do
      get :index
      should respond_with :unauthorized
    end
  end

  describe 'GET #show' do
    before do
      sign_in(@user)
    end

    it 'should show you number of votes' do
      answer = create(:answer, user: @user)
      answer2 = create(:answer, user: @user)
      5.times do
        create(:vote, answer: answer, score: 1)
      end
      2.times do
        create(:vote, answer: answer2, score: -1)
      end
      get :show, params: { id: @user.id }
      ans = user_hash(@user)
      ans[:votes] = 3
      expect(response.body).to eql(ans.to_json)
      should respond_with :ok
    end
  end

  def user_hash(user)
    { id: user.id,
      name: user.name,
      university_id: user.university_id }
  end
end
