# frozen_string_literal: true

class QuestionsController < ApplicationController
  skip_before_action :authenticate

  def index
    render_json(Question.select(:name), :ok)
  end

  def show
    question = Question
               .select(:name)
               .find_by(id: params[:id])
    render_json(question, :ok)
  end

  # def create
  #   answer = current_user.tasks.new answer_params
  #   answer.assign_question(params[:question_id]), current_user)
  #   if answer.save
  #     redirect_to questions_path
  #   else
  #     @answer = answer
  #     flash.now[:danger] = "Unable to create answer"
  #     render new_answer_path, status: :bad_request
  # end

  # def edit
  #    @answer = current_user.tasks.find params[:id]
  # end

  # def update

  # end

  #   def task_params
  #     params.require(:answer).permit(:content, :imgur, :question_id, :user_id)
  #   end
end
