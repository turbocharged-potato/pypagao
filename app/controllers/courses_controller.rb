# frozen_string_literal: true

class CoursesController < ApplicationController
  # /courses - lists all course objects
  # /courses?code=CS1101S - lists all course objects by search
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

  def create
    return unless ensure_params_fields([:code]) && check_university_id
    course = Course.new course_params
    if course.save
      render_json(course.slice(:id, :code), :ok)
    else
      render_error(course.errors.full_messages.join(', '), :bad_request)
    end
  end

  private

  def check_university_id
    if course_params[:university_id] != current_user.university_id
      render_error('University does not match current user', :bad_request)
      return
    end
    true
  end

  def course_params
    params.require(:course).permit(:university_id, :code)
  end
end
