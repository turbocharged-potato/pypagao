# frozen_string_literal: true

require 'rails_helper'
RSpec.describe AnswersController, type: :controller do
  before do
    @user_university = create(:university)
    @user = create(:user, university: @user_university)
    @course = create(:course, university: @user_university)
    @semester = create(:semester, course: @course)
    @paper = create(:paper, semester: @semester)
    @question = create(:question, paper: @paper)
  end

  describe '#GET index' do
    before do
      sign_in(@user)
    end

    it 'should list answer by question' do
      answer = create(:answer, question: @question)
      get :index, params: { question_id: @question.id }
      should respond_with :ok
      expect(JSON.parse(response.body))
        .to eql([answer_hash(answer).with_indifferent_access])
    end

    it 'should list answer by user' do
      other_user = create(:user, university: @user_university)
      answer = create(:answer, user: other_user, question: @question)
      get :index, params: { user_id: other_user.id }
      should respond_with :ok
      expect(JSON.parse(response.body))
        .to eql([answer_hash(answer).with_indifferent_access])
    end

    it 'should not list answers with different question id' do
      question = create(:question, paper: @paper)
      get :index, params: { question_id: question.id }
      should respond_with :ok
      expect(JSON.parse(response.body)).to eql([])
    end

    it 'should not list answers from different university' do
      non_user_university = create(:university)
      course = create(:course, university_id: non_user_university.id)
      semester = create(:semester, course_id: course.id)
      paper = create(:paper, semester_id: semester.id)
      question = create(:question, paper_id: paper.id)
      get :index, params: { question_id: question.id }
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

  # describe 'GET #show' do

  #   it 'should show you number of votes' do
  #     get :show
  #     should respond_with 3
  #   end
  # end

  describe 'POST #create' do
    before do
      sign_in(@user)
    end

    it 'should save given valid information' do
      answer = build(:answer, question: @question)
      post :create, params: answer_hash(answer)
      should respond_with :ok
      expect(response.body).to eq('')
    end

    it 'should not save information when university does not match' do
      university = create(:university)
      course = create(:course, university: university)
      semester = create(:semester, course: course)
      paper = create(:paper, semester: semester)
      question = create(:question, paper: paper)
      answer = build(:answer, question_id: question.id)
      post :create, params: answer_hash(answer)
      should respond_with :bad_request
      expect(response.body)
        .to eq({ error: 'University does not match current user' }.to_json)
    end

    it 'sends 400 when error saving' do
      answer = build(:answer, question: @question)
      allow_any_instance_of(Answer).to receive(:save).and_return(false)
      post :create, params: answer_hash(answer)
      should respond_with :bad_request
    end
  end

  private

  def answer_hash(answer)
    { id: answer.id,
      content: answer.content,
      imgur: answer.imgur,
      question_id: answer.question_id,
      user_id: answer.user_id }
  end
end
