# frozen_string_literal: true

# == Schema Information
#
# Table name: votes
#
#  id         :bigint(8)        not null, primary key
#  score      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  answer_id  :bigint(8)
#  user_id    :bigint(8)
#
# Indexes
#
#  index_votes_on_answer_id  (answer_id)
#  index_votes_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (answer_id => answers.id)
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to :user }
  it { should belong_to :answer }
  it { should validate_presence_of(:score) }
  it { should validate_inclusion_of(:score).in_array([-1, 0, 1]) }

  it 'has a valid factory' do
    expect(build(:vote)).to be_valid
  end
end
