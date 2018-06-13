# frozen_string_literal: true

# == Schema Information
#
# Table name: papers
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  semester_id :bigint(8)
#
# Indexes
#
#  index_papers_on_semester_id  (semester_id)
#

class Paper < ApplicationRecord
  belongs_to :semester
  has_many :questions, dependent: :destroy
end
