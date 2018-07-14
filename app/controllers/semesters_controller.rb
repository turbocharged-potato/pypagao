# frozen_string_literal: true

class SemestersController < ApplicationController
  # /semesters?course_id=1 - lists all semester objects by course
  def index
    return unless ensure_params_fields([:course_id])
    semesters = Semester.joins(course: :university)
                        .where(courses: { universities:
                                        { id: current_user.university_id } })
                        .select(:id, :start_year,
                                :end_year, :number,
                                :course_id)
                        .where(course_id: params[:course_id])
    render_json(semesters, :ok)
  end

  def create
    return unless ensure_params_fields(%i[end_year start_year number])
    semester = Semester.new semester_params
    if Course.find_by(id: semester[:course_id])
             .university_id != current_user.university_id
      render_error('University does not match current user', :bad_request)
    else
      try_save_semester(semester)
    end
  end

  def semester_params
    params.require(:semester).permit(:start_year,
                                     :end_year,
                                     :number,
                                     :course_id)
  end

  private

  def try_save_semester(semester)
    if semester.save
      render_json('', :ok)
    else
      render_error(semester.errors.full_messages.join(', '), :bad_request)
    end
  end
end
