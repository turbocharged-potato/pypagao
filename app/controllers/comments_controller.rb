# frozen_string_literal: true

class CommentsController < ApplicationController
  # /comments?answers_id=1 - lists all comment objects by answer
  def index
    return unless ensure_params_fields([:answer_id])
    comments = Comment.joins(answer: { user: :university })
                      .where(answers: { users:
                                      { universities:
                                      { id: current_user.university_id } } })
                      .select(:id, :answer_id, :content, :user_id)
                      .where(answer_id: params[:answer_id])
    render_json(comments, :ok)
  end

  def create
    return unless ensure_params_fields(%i[content answer_id])
    comment = Comment.new comment_params
    comment.user_id = current_user.id
    if comment_match_uni(comment)
      try_save_comment(comment)
    else
      render_error('University does not match current user', :bad_request)
    end
  end

  private

  def try_save_comment(comment)
    if comment.save
      render_json('', :ok)
    else
      render_error(comment.errors.full_messages.join(', '), :bad_request)
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :answer_id)
  end

  def comment_match_uni(comment)
    comment.answer.question.paper.semester.course.university ==
      current_user.university
  end
end
