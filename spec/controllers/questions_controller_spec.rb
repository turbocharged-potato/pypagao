# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  before do
    @user_university = create(:university)
    @user = create(:user, university: @user_university)
    code = 'CS1101S'
    @course = create(:course, code: code, university: @user_university)
    @semester = create(:semester,
                       course: @course)
    @paper = create(:paper,
                    semester: @semester)
  end

  describe '#GET index' do
    before do
      sign_in(@user)
    end

    it 'should list question by paper' do
      question = create(:question, paper: @paper)
      get :index, params: { paper_id: @paper.id }
      should respond_with :ok
      expect(JSON.parse(response.body))
        .to eql([question_hash(question).with_indifferent_access])
    end

    it 'should not list question with different paper id' do
      paper = create(:paper, semester: @semester)
      get :index, params: { paper_id: paper.id }
      should respond_with :ok
      expect(JSON.parse(response.body)).to eql([])
    end

    it 'should not list questions from different university' do
      non_user_university = create(:university)
      course = create(:course, university_id: non_user_university.id)
      semester = create(:semester, course_id: course.id)
      paper = create(:paper, semester_id: semester.id)
      get :index, params: { paper_id: paper.id }
      should respond_with :ok
      expect(JSON.parse(response.body)).to eql([])
    end
  end

  describe 'GET #index if signed out' do
    it 'should not list any questions if signed out' do
      get :index
      should respond_with :unauthorized
    end
  end

  describe 'POST #create' do
    before do
      sign_in(@user)
    end

    it 'should save given valid information' do
      question = build(:question, paper: @paper)
      post :create, params: question_hash(question)
      should respond_with :ok
      expect(response.body).to eq('')
    end

    it 'should not save information when university does not match' do
      university = create(:university)
      course = create(:course, university: university)
      semester = create(:semester, course: course)
      paper = create(:paper, semester: semester)
      question = build(:question, paper: paper)
      post :create, params: question_hash(question)
      should respond_with :bad_request
      expect(response.body)
        .to eq({ error: 'University does not match current user' }.to_json)
    end

    it 'sends 400 when error saving' do
      question = build(:question, paper: @paper)
      allow_any_instance_of(Question).to receive(:save).and_return(false)
      post :create, params: question_hash(question)
      should respond_with :bad_request
    end
  end

  private

  def question_hash(question)
    { id: question.id,
      name: question.name,
      paper_id: question.paper_id }
  end
end
