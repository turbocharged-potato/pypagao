# frozen_string_literal: true

class QuestionsController < ApplicationController
  skip_before_action :authenticate

  # /comments?answers_id=1 - lists all comment objects by answer
  def index
    return unless ensure_params_fields([:answer_id])
    comments_selected = Comment.select(:id, :content, :user_id, :answer_id)
    comments = comments_selected.where(answer_id: params[:answer_id])
    render_json(comments, :ok)
  end

  def show
    question = Question
               .select(:name)
               .find_by(id: params[:id])
    render_json(question, :ok)
  end

  def create
    return unless ensure_params_fields(:name)
    if Question.create(question_params)
      render_json('', :ok)
    else
      render_error('Error saving', :internal_server_error)
    end
  end

  def question_params
    params.require(:question).permit(:name)
  end
end
