# frozen_string_literal: true

# == Schema Information
#
# Table name: semesters
#
#  id         :bigint(8)        not null, primary key
#  end_year   :integer
#  number     :integer
#  start_year :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :bigint(8)
#
# Indexes
#
#  index_semesters_on_course_id  (course_id)
#

FactoryBot.define do
  factory :semester do
    start_year 1
    end_year 1
    number 1
    paper ''
  end
end
