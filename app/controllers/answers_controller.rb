class AnswersContoller < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
  def index
    @answers = Answer.search params[:search]
    render_json(Answers.select(:content, :imgur, :question_id, :user_id), :ok)
  end

  def show
    @answers = Answer.find(params[:id])
    @comments = Answer.comments
    @votes = Answer.votes
    render_json(@answers.select(:content, :imgur, :question_id, :user_id), :ok)
  end

  def new
    @task = current_user.answers.new
  end
 
  def create
    answer = current_user.tasks.new answer_params
    answer.assign_question(params[:question_id]), current_user)
    if answer.save
      redirect_to questions_path
    else
      @answer = answer
      flash.now[:danger] = "Unable to create answer"
      render new_answer_path, status: :bad_request
  end

  def edit
     @answer = current_user.tasks.find params[:id]
  end

  def update

  end
  

    def task_params
      params.require(:answer).permit(:content, :imgur, :question_id, :user_id)
    end


end