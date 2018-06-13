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

require 'rails_helper'

RSpec.describe Paper, type: :model do
  it { should belong_to :semester }
  it { should have_many(:questions).dependent(:destroy) }
end
