# frozen_string_literal: true

# == Schema Information
#
# Table name: semesters
#
#  id         :bigint(8)        not null, primary key
#  end_year   :integer          not null
#  number     :integer          not null
#  start_year :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :bigint(8)
#
# Indexes
#
#  index_semesters_on_course_id  (course_id)
#

class Semester < ApplicationRecord
  belongs_to :course
  has_many :papers, dependent: :destroy

  validates :number, presence: true, inclusion: { in: [1, 2] }
  validates :start_year, presence: true
  validates :end_year, presence: true
  validate :start_year_right_before_end_year

  # rubocop:disable Style/GuardClause
  def start_year_right_before_end_year
    unless end_year && start_year && end_year - start_year == 1
      errors.add(:end_year, 'must be right after start_year')
    end
  end
  # rubocop:enable Style/GuardClause
end
