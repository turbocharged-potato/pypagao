# frozen_string_literal: true

class SemestersController < ApplicationController
  skip_before_action :authenticate

  # /semesters?course_id=1 - lists all semester objects by course
  def index
    return unless ensure_params_fields([:course_id])
    semesters_selected = Semester.select(:id, :start_year, :end_year, :number, :course_id)
    semesters = semesters_selected.where(course_id: params[:course_id])
    render_json(semesters, :ok)
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
    params.require(:semester).permit(:start_year, :end_year, :number)
  end
end
