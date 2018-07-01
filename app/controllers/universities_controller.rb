# frozen_string_literal: true

class UniversitiesController < ApplicationController
  skip_before_action :authenticate

  def index
    render_json(University.select(:id, :name, :domain), :ok)
  end

  def show
    university = University
                 .select(:id, :name, :domain)
                 .find_by(id: params[:id])
    render_json(university, :ok)
  end

  def create
    return unless ensure_params_fields(%i[name domain])
    if University.create(university_params)
      render_json('', :ok)
    else
      render_error('Error saving', :internal_server_error)
    end
  end

  private

  def university_params
    params.require(:university).permit(:name, :domain)
  end

  def edit
    @university = University.find params[:id]
    render_json(@university.select(:id, :name, :domain), :ok)
  end

  def update
    university = University.find params[:id]
    if university.update(university_params)
      flash[:success] = 'University details updated'
      redirect_to @university
    else
      render 'edit'
    end
  end
end
