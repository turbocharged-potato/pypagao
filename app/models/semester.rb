# frozen_string_literal: true

class Semester < ApplicationRecord
  belongs_to :course
  has_many :papers, dependent: :destroy
end
