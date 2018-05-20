# frozen_string_literal: true

class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :answers, dependent: :destroy
  belongs_to :university
end
