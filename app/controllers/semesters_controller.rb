# frozen_string_literal: true

class SemestersController < ApplicationController
  skip_before_action :authenticate

  def index
    return unless ensure_params_fields([:course_id])
    semesters_selected = Semester.select(:start_year, :end_year, :number, :id)
    semesters = semesters_selected.find_by(course_id: params[:course_id])
    render_json(semesters, :ok)
  end

  def show
    semester = Semester
               .select(:start_year, :end_year, :number, :id)
               .find_by(id: params[:id])
    papers_selected = semester.papers.select(:id, :name)
    render_json([semester, papers_selected], :ok)
  end

  def create
    return unless ensure_params_fields(:end_year, :start_year, :number)
    if Semester.create(semester_params)
      render_json('', :ok)
    else
      render_error('Error saving', :internal_server_error)
    end
  end

  def semester_params
    params.require(:course).permit(:start_year, :end_year, :number)
  end
end
