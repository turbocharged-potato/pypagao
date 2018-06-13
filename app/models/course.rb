# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id            :bigint(8)        not null, primary key
#  code          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  university_id :bigint(8)
#
# Indexes
#
#  index_courses_on_university_id  (university_id)
#

class Course < ApplicationRecord
  belongs_to :university
  has_many :semesters, dependent: :destroy
  validates :code, presence: true
end
