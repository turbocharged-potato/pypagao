# frozen_string_literal: true

class UsersController < ApplicationController
  # /users - lists all user objects
  # /users?university_id=id - lists all users objects by university
  # /users?name=Tiffany - searches for users by name
  # /users?rank=true - ranks user based on number of votes # not implemented

  # /users/1 - shows user stats by id

  def index
    users = User.select(:id, :university_id, :name)
    if params[:university_id]
      users = users.where(university_id: params[:university_id])
    end
    users = users.where(name: params[:name]) if params[:name]
    render_json(users, :ok)
  end

  def show
    user = User.find_by(id: params[:id]).slice(:id, :name, :university_id)
    user[:votes] = get_score(params[:id])
    render_json(user, :ok)
  end

  private

  def user_params
    params.require(:course).permit(:code)
  end

  def get_score(id)
    votes = Vote.joins(answer: :user)
                .where(answers: { users: { id: id } })
    votes.where(score: 1).size - votes.where(score: -1).size
  end
end
