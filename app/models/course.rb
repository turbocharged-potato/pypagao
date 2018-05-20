# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :university
  has_many :semesters, dependent: :destroy
end
