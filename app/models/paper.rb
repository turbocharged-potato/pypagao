# frozen_string_literal: true

class Paper < ApplicationRecord
  belongs_to :semester
  has_many :questions, dependent: :destroy
end
