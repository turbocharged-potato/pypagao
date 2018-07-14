# frozen_string_literal: true

class CoursesController < ApplicationController
  # /courses?university_id=1 - lists all course objects by university
  def index
    return unless ensure_params_fields([:university_id])
    courses = Course
              .select(:id, :university_id, :code)
              .where(university_id: params[:university_id])
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
