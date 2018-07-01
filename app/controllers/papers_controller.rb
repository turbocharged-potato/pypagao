# frozen_string_literal: true

class PapersController < ApplicationController
  skip_before_action :authenticate

  # /papers?semester_id=1 - lists all paper objects by semester
  def index
    return unless ensure_params_fields([:semester_id])
    papers_selected = Paper.select(:id, :name, :semester_id)
    papers = papers_selected.where(semester_id: params[:semester_id])
    render_json(papers, :ok)
  end

  def show
    paper = Paper
            .select(:name)
            .find_by(id: params[:id])
    questions = paper.questions
    questions_selected = questions.select(:id, :name)
    render_json([papers, questions_selected], :ok)
  end

  def create
    return unless ensure_params_fields(:name)
    if Paper.create(paper_params)
      render_json('', :ok)
    else
      render_error('Error saving', :internal_server_error)
    end
  end

  def paper_params
    params.require(:paper).permit(:name)
  end
end
