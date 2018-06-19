# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  paper_id   :bigint(8)
#
# Indexes
#
#  index_questions_on_paper_id  (paper_id)
#

require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should belong_to :paper }
  it { should have_many(:answers).dependent(:destroy) }
  it { should validate_presence_of(:name) }

  it 'has a valid factory' do
    expect(build(:question)).to be_valid
  end
end
