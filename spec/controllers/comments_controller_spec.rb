# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before do
    @user_university = create(:university)
    @user = create(:user, university: @user_university)
    user = create(:user, university: @user_university)
    @course = create(:course, university: @user_university)
    @semester = create(:semester, course: @course)
    @paper = create(:paper, semester: @semester)
    @question = create(:question, paper: @paper)
    @answer = create(:answer, question: @question, user: user)
  end

  describe '#GET index' do
    before do
      sign_in(@user)
    end

    it 'should list comments by answer' do
      comment = create(:comment, answer: @answer, user: @user)
      get :index, params: { answer_id: @answer.id }
      should respond_with :ok
      expect(JSON.parse(response.body))
        .to eql([comment_hash(comment).with_indifferent_access])
    end

    it 'should not list comments with different answer id' do
      answer = create(:answer, question: @question)
      get :index, params: { answer_id: answer.id }
      should respond_with :ok
      expect(JSON.parse(response.body)).to eql([])
    end

    it 'should not list comments from different university' do
      # creating a valid answer in another university
      university = create(:university)
      course = create(:course, university: university)
      semester = create(:semester, course: course)
      paper = create(:paper, semester: semester)
      question = create(:question, paper: paper)
      user = create(:user, university: university)
      answer = create(:answer, question: question, user: user)
      get :index, params: { answer_id: answer.id }
      should respond_with :ok
      expect(JSON.parse(response.body)).to eql([])
    end
  end

  describe 'GET #index if signed out' do
    it 'should not list any comments if signed out' do
      get :index
      should respond_with :unauthorized
    end
  end

  describe 'POST #create' do
    before do
      sign_in(@user)
    end

    it 'should save given valid information' do
      comment = build(:comment, answer: @answer)
      post :create, params: comment_hash(comment)
      should respond_with :ok
      expect(response.body).to eq('')
    end

    it 'should not save information when university does not match' do
      # creating a valid answer in another university
      university = create(:university)
      course = create(:course, university: university)
      semester = create(:semester, course: course)
      paper = create(:paper, semester: semester)
      question = create(:question, paper: paper)
      user = create(:user, university: university)
      answer = create(:answer, question: question, user: user)
      sign_in(@user)
      comment = build(:comment, answer: answer)
      post :create, params: comment_hash(comment)
      should respond_with :bad_request
      expect(response.body)
        .to eq({ error: 'University does not match current user' }.to_json)
    end

    it 'sends 400 when error saving' do
      comment = build(:comment, answer: @answer)
      allow_any_instance_of(Comment).to receive(:save).and_return(false)
      post :create, params: comment_hash(comment)
      should respond_with :bad_request
    end
  end

  private

  def comment_hash(comment)
    { id: comment.id,
      content: comment.content,
      user_id: comment.user_id,
      answer_id: comment.answer_id }
  end
end
