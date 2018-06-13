# frozen_string_literal: true

# == Schema Information
#
# Table name: papers
#
#  id          :bigint(8)        not null, primary key
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  semester_id :bigint(8)
#
# Indexes
#
#  index_papers_on_semester_id  (semester_id)
#

require 'rails_helper'

RSpec.describe Paper, type: :model do
  it { should belong_to :semester }
  it { should have_many(:questions).dependent(:destroy) }
  it { should validate_presence_of(:name) }

  it 'has a valid factory' do
    expect(build(:paper)).to be_valid
  end
end
