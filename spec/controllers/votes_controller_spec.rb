# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  before do
    @user_university = create(:university)
    @user = create(:user, university: @user_university)
    user = create(:user, university: @user_university)
    @course = create(:course, university: @user_university)
    @semester = create(:semester, course: @course)
    @paper = create(:paper, semester: @semester)
    @question = create(:question, paper: @paper)
    sign_in(user)
    @answer = create(:answer, question: @question)
  end

  describe 'POST #create' do
    before do
      sign_in(@user)
    end

    it 'should save given valid information' do
      vote = build(:vote, answer: @answer)
      post :create, params: vote_hash(vote)
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
      sign_in(user)
      answer = create(:answer, question: question)
      sign_in(@user)
      vote = build(:vote, answer: answer)
      post :create, params: vote_hash(vote)
      should respond_with :bad_request
      expect(response.body)
        .to eq({ error: 'University does not match current user' }.to_json)
    end

    it 'sends 400 when error saving' do
      vote = build(:vote, answer: @answer)
      allow_any_instance_of(Vote).to receive(:save).and_return(false)
      post :create, params: vote_hash(vote)
      should respond_with :bad_request
    end
  end

  private

  def vote_hash(vote)
    { id: vote.id,
      score: vote.score,
      user_id: vote.user_id,
      answer_id: vote.answer_id }
  end
end
