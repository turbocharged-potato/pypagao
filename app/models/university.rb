# frozen_string_literal: true

class University < ApplicationRecord
  has_many :courses, dependent: :destroy
  has_many :users, dependent: :destroy
end
