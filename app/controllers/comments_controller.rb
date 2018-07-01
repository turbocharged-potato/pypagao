# frozen_string_literal: true

class QuestionsController < ApplicationController
  skip_before_action :authenticate

  # /comments?answers_id=1 - lists all comment objects by answer
  def index
    return unless ensure_params_fields([:answer_id])
    comments_selected = Comment.select(:id, :content, :user_id, :answer_id)
    comments = comments_selected.where(answer_id: params[:answer_id])
    render_json(comments, :ok)
  end

  def create
    return unless ensure_params_fields(:content)
    if Comment.create(comment_params)
      render_json('', :ok)
    else
      render_error('Error saving', :internal_server_error)
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
