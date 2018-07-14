# frozen_string_literal: true

class CoursesController < ApplicationController
  # /courses?code=CS1101S - gives one course object from the uni of the user
  def index
    return unless ensure_params_fields([:code])
    courses = Course.select(:id, :code, :university_id)
                    .where(university_id: current_user.university_id)
                    .find_by(code: params[:code])
    render_json(courses, :ok)
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
