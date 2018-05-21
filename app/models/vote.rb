# frozen_string_literal: true

class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :answer
end
