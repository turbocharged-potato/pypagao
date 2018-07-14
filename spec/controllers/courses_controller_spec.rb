# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe 'GET #index' do
    before do
      @user_university = create(:university)
      @user = create(:user, university: @user_university)
      sign_in(@user)
    end

    it 'should lists courses from a certain university' do
      course = create(:course, university: @user_university)
      get :index
      should respond_with :ok
      expect(JSON.parse(response.body))
        .to eql([{
          id: course.id,
          code: course.code,
          university_id: course.university_id
        }.with_indifferent_access])
    end

    it 'should search for course code' do
      code = 'CS1101S'
      course = create(:course, code: code, university: @user_university)
      get :index, params: { code: code }
      expect(JSON.parse(response.body))
        .to eql({ id: course.id,
                  code: course.code,
                  university_id: course.university_id }.with_indifferent_access)
    end

    it 'should not list courses from different university' do
      non_user_university = create(:university)
      get :index, params: { university_id: non_user_university.id }
      should respond_with :ok
      expect(JSON.parse(response.body)).to eql([])
    end
  end

  describe 'GET #index if signed out' do
    it 'should not list any courses if signed out' do
      @user_university = create(:university)
      get :index
      should respond_with :unauthorized
    end
  end

  describe 'POST #create' do
    before do
      @user_university = create(:university)
      @user = create(:user, university: @user_university)
      sign_in(@user)
    end

    it 'should save given valid information' do
      course = build(:course)
      post :create, params: { code: course.code }
      course_id = Course.find_by(code: course.code).id
      should respond_with :ok
      expect(JSON.parse(response.body))
        .to eql({ id: course_id, code: course.code }.with_indifferent_access)
    end

    it 'sends 400 when error saving' do
      course = build(:course)
      Course.any_instance.stub(:save).and_return(false)
      post :create, params: { code: course.code }
      should respond_with :bad_request
    end
  end
end
