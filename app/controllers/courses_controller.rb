# frozen_string_literal: true

class CoursesController < ApplicationController
  # /courses - lists all course objects by university
  # /courses?code=CS1101S
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
    return unless ensure_params_fields([:code])
    course = Course.new course_params
    if course[:university_id] != current_user.university_id
      render_error('University does not match current user', :bad_request)
    elsif course.save
      render_json('', :ok)
    else
      render_error(course.errors.full_messages.join(', '), :bad_request)
    end
  end

  def course_params
    params.require(:course).permit(:university_id, :code)
  end
end
