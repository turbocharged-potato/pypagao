# frozen_string_literal: true

class PapersController < ApplicationController
  skip_before_action :authenticate

  def index
    if params[:semester_id]
      papers_selected = Paper.select(:id, :name)
      papers = papers_selected.find_by(semester_id: params[:semesters_id])
      render_json(papers, :ok)
    end
  end

  def show
    paper = Papers
              .select(:name)
              .find_by(id: params[:id])
  end

  def create
    return unless ensure_params_fields(:name)
    if Paper.create(paper_params)
      render_json('', :ok)
    else
      render_error('Error saving', :internal_server_error)
    end
  end

    def course_params
      params.require(:course).permit(:code)
    end

end
