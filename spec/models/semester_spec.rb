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

require 'rails_helper'

RSpec.describe Semester, type: :model do
  it { should belong_to :course }
  it { should have_many(:papers).dependent(:destroy) }
  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:start_year) }
  it { should validate_presence_of(:end_year) }
  it { should validate_inclusion_of(:number).in_array([1, 2]) }

  it 'accepts start year right after end year' do
    expect(build(:semester)).to be_valid
  end

  it 'rejects start year not right after end year' do
    expect(build(:semester, start_year: 2016, end_year: 2018)).to_not be_valid
  end

  it 'has a valid factory' do
    expect(build(:semester)).to be_valid
  end
end
