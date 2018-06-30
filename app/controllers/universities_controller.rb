# frozen_string_literal: true

class UniversitiesController < ApplicationController
  skip_before_action :authenticate

  def index
    render_json(University.select(:id, :name, :domain), :ok)
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
end
