# frozen_string_literal: true

class CoursesController < ApplicationController
  skip_before_action :authenticate

  def index
    courses_selected = Course.select(:id, :code, :university_id)
    courses_selected_filtered = courses_selected.where(university_id: 1)
    courses = if params[:code]
                courses_selected_filtered.find_by(code: params[:code])
              else
                courses_selected_filtered.all
              end
    render_json(courses, :ok)
  end

  def show
    course = Course
             .select(:id, :code, :university_id)
             .find_by(id: params[:id])
    semesters_selected = course.semesters
                               .select(:id, :end_year, :start_year, :number)
    render_json([course, semesters_selected], :ok)
  end

  def create
    return unless ensure_params_fields(:code)
    if Course.create(course_params)
      render_json('', :ok)
    else
      render_error('Error saving', :internal_server_error)
    end
  end

  def course_params
    params.require(:course).permit(:code)
  end
end
