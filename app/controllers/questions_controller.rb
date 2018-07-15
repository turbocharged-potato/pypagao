# frozen_string_literal: true

class QuestionsController < ApplicationController
  # /questions?paper_id=1 - lists all question objects by paper

  def index
    return unless ensure_params_fields([:paper_id])
    questions = Question.joins(paper: { semester: { course: :university } })
                        .where(papers: { semesters:
                                       { courses:
                                       { universities:
                                       { id: current_user.university_id } } } })
                        .select(:id, :paper_id, :name)
                        .where(paper_id: params[:paper_id])
    render_json(questions, :ok)
  end

  def create
    return unless ensure_params_fields(%i[name paper_id])
    question = Question.new question_params
    if question.paper.semester.course.university == current_user.university
      try_save_question(question)
    else
      render_error('University does not match current user', :bad_request)
    end
  end

  private

  def try_save_question(question)
    if question.save
      render_json('', :ok)
    else
      render_error(question.errors.full_messages.join(', '), :bad_request)
    end
  end

  def question_params
    params.require(:question).permit(:name, :paper_id)
  end
end
