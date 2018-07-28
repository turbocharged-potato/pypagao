# frozen_string_literal: true

class CoursesController < ApplicationController
  # /courses - lists all course objects
  # /courses?code=CS1101S - lists course objects by search
  # /courses/1 - lists course objects by id

  def index
    courses_by_university = Course
                            .select(:id, :university_id, :code)
                            .where(university_id: current_user.university_id)

    courses = if params[:code]
                courses_by_university.find_by(code: params[:code])
              else
                courses_by_university
              end

    render_json(courses, :ok)
  end

  def show
    courses_by_university = Course
                            .select(:id, :university_id, :code)
                            .where(university_id: current_user.university_id)

    course = courses_by_university.find_by(id: params[:id])
    render_json(course, :ok)
  end

  def create
    return unless ensure_params_fields([:code])
    course = Course.new course_params
    course.university_id = current_user.university_id
    if course.save
      render_json(course.slice(:id, :code), :ok)
    else
      render_error(course.errors.full_messages.join(', '), :bad_request)
    end
  end

  private

  def course_params
    params.require(:course).permit(:code)
  end
end
