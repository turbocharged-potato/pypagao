# frozen_string_literal: true

class QuestionsController < ApplicationController
  skip_before_action :authenticate

  # /questions?paper_id=1 - lists all question objects by paper
  def index
    return unless ensure_params_fields([:paper_id])
    questions_selected = Question.select(:id, :name, :paper_id)
    questions = questions_selected.where(paper_id: params[:paper_id])
    render_json(questions, :ok)
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
