# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id            :bigint(8)        not null, primary key
#  code          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  university_id :bigint(8)
#
# Indexes
#
#  index_courses_on_university_id  (university_id)
#

require 'rails_helper'

RSpec.describe Course, type: :model do
  it { should belong_to :university }
  it { should have_many(:semesters).dependent(:destroy) }
end
