# frozen_string_literal: true

class PapersController < ApplicationController
  # /papers?semester_id=1 - lists all paper objects by semester
  def index
    return unless ensure_params_fields([:semester_id])
    papers = Paper.joins(semester: { course: :university })
                  .where(semesters: { courses:
                                    { universities:
                                    { id: current_user.university_id } } })
                  .select(:id, :semester_id, :name)
                  .where(semester_id: params[:semester_id])
    render_json(papers, :ok)
  end

  def create
    return unless ensure_params_fields(%[name semester_id])
    paper = Paper.new paper_params
    if paper.semester.course.university == current_user.university
      try_save_paper(paper)
    else
      render_error('University does not match current user', :bad_request)
    end
  end

  private

  def paper_params
    params.require(:paper).permit(:name, :semester_id)
  end

  def try_save_paper(paper)
    if paper.save
      render_json('', :ok)
    else
      render_error(paper.errors.full_messages.join(', '), :bad_request)
    end
  end
end
