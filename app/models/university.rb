# frozen_string_literal: true

# == Schema Information
#
# Table name: universities
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class University < ApplicationRecord
  has_many :courses, dependent: :destroy
  has_many :users, dependent: :destroy
end
