# frozen_string_literal: true

class VotesController < ApplicationController
  def create
    return unless ensure_params_fields(%i[score answer_id])
    vote = Vote.new vote_params
    vote.user_id = current_user.id
    if vote_match_uni(vote)
      try_save_vote(vote)
    else
      render_error('University does not match current user', :bad_request)
    end
  end

  private

  def try_save_vote(vote)
    if vote.save
      render_json('', :ok)
    else
      render_error(vote.errors.full_messages.join(', '), :bad_request)
    end
  end

  def vote_params
    params.require(:vote).permit(:score, :answer_id)
  end

  def vote_match_uni(vote)
    vote.answer.question.paper.semester.course.university ==
      current_user.university
  end
end
