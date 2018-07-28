# frozen_string_literal: true

class AnswersController < ApplicationController
  # /answers?user_id=1 - lists all answer objects by user or question
  # /answers?question_id=1&limit=2 - limits answer objects by votes

  # possible development
  # /answers?q=make_fact - lists relevent answers

  def index
    return unless ensure_correct_param
    answers = filter_answers
    limit_answers(answers, params[:limit]) if params[:limit]
    render_json(answers, :ok)
  end

  # /answers/1 - lists number of votes for an answer with certain id
  def show
    answer = Answer.find_by(id: params[:id]).slice(:id, :content)
    answer[:votes] = get_score(params[:id])
    render_json(answer, :ok)
  end

  def create
    return unless ensure_params_fields(%i[content question_id imgur])
    answer = Answer.new answer_params
    answer.user_id = current_user.id
    if answer_match_uni(answer)
      try_save_answer(answer)
    else
      render_error('University does not match current user', :bad_request)
    end
  end

  private

  def ensure_correct_param
    unless params[:user_id] || params[:question_id]
      render_error('Missing parameter', :unprocessable_entity)
      return
    end
    true
  end

  def filter_answers
    if params[:user_id]
      select_answers.where(user_id: params[:user_id])
    elsif params[:question_id]
      select_answers.where(question_id: params[:question_id])
    end
  end

  def select_answers
    filter_ans_by_uni.select(:id, :content, :imgur, :question_id, :user_id)
  end

  def filter_ans_by_uni
    Answer.joins(question: { paper: { semester: { course: :university } } })
          .where(questions: { papers:
                            { semesters:
                            { courses:
                            { universities:
                            { id: current_user.university_id } } } } })
  end

  def limit_answers(answers, answer_limit)
    answers.sort_by { |answer| get_score(answer[:id]) }
           .limit(answer_limit)
  end

  def answer_params
    params.require(:answer).permit(:content, :imgur, :question_id)
  end

  def get_score(answer_id)
    positives = Vote.where('answer_id=? and score=?', answer_id, 1).size
    negatives = Vote.where('answer_id=? and score=?', answer_id, -1).size
    positives - negatives
  end

  def answer_match_uni(answer)
    answer.question.paper.semester.course.university_id ==
      current_user.university_id
  end

  def try_save_answer(answer)
    if answer.save
      render_json('', :ok)
    else
      render_error(answer.errors.full_messages.join(', '), :bad_request)
    end
  end
end
