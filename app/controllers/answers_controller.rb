# frozen_string_literal: true

class AnswersContoller < ApplicationController
  skip_before_action :authenticate

  # /answers?user_id=1 - lists all answer objects by user or question
  # /answers?question_id=1&limit=2 - limits answer objects by votes

  def index
    return unless ensure_correct_param
    answers = filter_answers
    limit_answers(answers, answer_limit) if params[:limit]
    render_json(answers, :ok)
  end

  def ensure_correct_param
    unless params[:user_id] || params[:question_id]
      render_error('Missing parameter', :unprocessable_entity)
      return
    end
    true
  end

  def limit_answers(answers, answer_limit)
    answers.sort_by { |answer| get_score(answer[:id]) }
           .limit(answer_limit)
  end

  def filter_answers
    if params[:user_id]
      select_answers.where(user_id: params[:user_id])
    elsif params[:question_id]
      select_answers.where(question_id: params[:question_id])
    end
  end

  def select_answers
    Answer.select(:id, :content, :imgur, :question_id, :user_id)
  end

  # /answers/1 - lists number of votes for an answer with answer_id
  def show
    get_score(select_answers.find_by(answer_id: params[:answer_id]).id)
  end

  def get_score(answer_id)
    positives = Vote.where('answer_id=? and score=?', answer_id, 1).count
    negatives = Vote.where('answer_id=? and score=?', answer_id, -1).count
    positives - negatives
  end

  def create
    return unless ensure_params_fields(:content)
    if Paper.create(paper_params)
      render_json('', :ok)
    else
      render_error('Error saving', :internal_server_error)
    end
  end

  def answers_params
    params.require(:paper).permit(:content, :imgur)
  end
end
