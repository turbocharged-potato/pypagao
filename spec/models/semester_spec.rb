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

require 'rails_helper'

RSpec.describe Semester, type: :model do
  it { should belong_to :course }
  it { should have_many(:papers).dependent(:destroy) }
end
