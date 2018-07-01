# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate

  def index
    render_json(User.select(:name), :ok)
  end

  def show
    user = User
           .select(:name)
           .find_by(id: params[:id])
    # answers = user.answers
    render_json(user, answers, :ok)
  end

  def new
    if logged_in?
      redirect_to questions_path
      return
    end
    @user = User.new
  end

  # def create
  #   if logged_in?
  #     redirect_to questions_path
  #     return
  #   end

  #   @user = User.new user_params
  #   if @user.save
  #     log_in @user
  #     flash[:success] = 'You have been successfully registered'
  #     redirect_to tasks_path
  #   else
  #     flash.now[:danger] = @user.errors.full_messages.join(', ')
  #     render 'new', status: :bad_request
  #   end
  # end

  # def edit
  #   @user = User.find current_user.id
  # end

  # def update
  #   user = User.find current_user.id
  #   if params[:change] == 'details'
  #     status = user.update(user_params)
  #   elsif params[:change] == 'password'
  # && user.authenticate(params[:user][:current_password])
  #     status = user.update(user_params)
  #   end
  #   if status
  #     flash[:success] = 'Successfully updated details'
  #     redirect_to current_user
  #   else
  #     @user = user
  #     flash.now[:danger] = user.errors.full_messages.join(', ')
  #     flash.now[:danger] ||= 'Error! Please try again'
  #     render 'edit', status: :bad_request
  #   end
  # end

  # def user_params
  #   params.require(:user).permit(:email, :name, :password_digest,
  #  :password_confirmation, :university_id)
  # end
end
