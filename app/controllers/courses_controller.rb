# frozen_string_literal: true

class CoursesController < ApplicationController
  skip_before_action :authenticate

  # /courses?code=CS1101S - gives one course object from the uni of the user
  def index
    return unless ensure_params_fields([:code])
    courses_selected = Course.select(:id, :code, :university_id)
    courses_selected_from_uni = courses_selected.where(university_id: 1)
    # change 1 to current_user.university_id

    courses = courses_selected_from_uni.where(code: params[:code])
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
