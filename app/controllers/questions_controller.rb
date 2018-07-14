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
    return unless ensure_params_fields([:name])
    question = Question.new question_params
    if question_match_uni(question)
      try_save_question(question)
    else
      render_error('University does not match current user', :bad_request)
    end
  end

  private

  def question_match_uni(question)
    paper = Paper.find_by(id: question[:paper_id])
    semester = Semester.find_by(id: paper[:semester_id])
    course = Course.find_by(id: semester[:course_id])
    course.university_id == current_user.university_id
  end

  def try_save_question(question)
    if question.save
      render_json('', :ok)
    else
      render_error(semester.errors.full_messages.join(', '), :bad_request)
    end
  end

  def question_params
    params.require(:question).permit(:name, :paper_id)
  end
end
