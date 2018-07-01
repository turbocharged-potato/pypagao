# frozen_string_literal: true

class AnswersContoller < ApplicationController
  skip_before_action :authenticate

  # /answers?question_id=1&limit=2 - limits answer objects by question
  # /answers?user_id=1 - lists all answer objects by user

  def index
    return unless ensure_params_fields([:semester_id])
    papers_selected = Paper.select(:id, :name)
    papers = papers_selected.where(semester_id: params[:semester_id])
    render_json(papers, :ok)
  end

  # /answers/1 - lists number of votes for an answer with answer_id
  
  def show
  end

  def new
    @task = current_user.answers.new
  end

  def create
    return unless ensure_params_fields(:content)
    if Paper.create(paper_params)
      render_json('', :ok)
    else
      render_error('Error saving', :internal_server_error)
    end
  end

  def paper_params
    params.require(:paper).permit(:content, :imgur)
  end
end
