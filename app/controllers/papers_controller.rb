# frozen_string_literal: true

class PapersController < ApplicationController
  skip_before_action :authenticate

  def index
    return unless ensure_params_fields([:semester_id])
    papers_selected = Paper.select(:id, :name)
    papers = papers_selected.find_by(semester_id: params[:semesters_id])
    render_json(papers, :ok)
  end

  def show
    paper = Papers
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
