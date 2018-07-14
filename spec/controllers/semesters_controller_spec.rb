# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SemestersController, type: :controller do
  describe 'GET #index' do
    before do
      @user_university = create(:university)
      @user = create(:user, university: @user_university)
      @code = 'CS1101S'
      @course = create(:course, code: @code, university: @user_university)
      sign_in(@user)
    end

    it 'should list semester by course' do
      semester = create(:semester, course: @course)
      get :index, params: { course_id: @course.id }
      should respond_with :ok
      expect(JSON.parse(response.body))
        .to eql([semester_hash(semester).with_indifferent_access])
    end

    it 'should not list semesters with different course id' do
      course = create(:course, university: @user_university)
      get :index, params: { course_id: course.id }
      should respond_with :ok
      expect(JSON.parse(response.body)).to eql([])
    end

    it 'should not list courses from different university' do
      non_user_university = create(:university)
      course = create(:course, university_id: non_user_university.id)
      get :index, params: { course_id: course.id }
      should respond_with :ok
      expect(JSON.parse(response.body)).to eql([])
    end
  end

  describe 'GET #index if signed out' do
    it 'should not list any courses if signed out' do
      get :index
      should respond_with :unauthorized
    end
  end

  describe 'POST #create' do
    before do
      @user_university = create(:university)
      @user = create(:user, university: @user_university)
      @code = 'CS1101S'
      @course = create(:course, code: @code, university: @user_university)
      sign_in(@user)
    end

    it 'should save given valid information' do
      semester = build(:semester, course_id: @course.id)
      post :create, params: semester_hash(semester)
      should respond_with :ok
      expect(response.body).to eq('')
    end

    it 'should not save information when university does not match' do
      university = create(:university)
      course = create(:course, university: university)
      semester = build(:semester, course_id: course.id)
      post :create, params: semester_hash(semester)
      should respond_with :bad_request
      expect(response.body)
        .to eq({ error: 'University does not match current user' }.to_json)
    end

    it 'sends 400 when error saving' do
      semester = build(:semester)
      allow(Course).to receive(:create).and_return(false)
      post :create, params: semester_hash(semester)
      should respond_with :bad_request
    end
  end

  private

  def semester_hash(semester)
    { id: semester.id,
      start_year: semester.start_year,
      end_year: semester.end_year,
      number: semester.number,
      course_id: semester.course_id }
  end
end
