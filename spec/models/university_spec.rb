# frozen_string_literal: true

# == Schema Information
#
# Table name: universities
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe University, type: :model do
  it { should have_many(:courses).dependent(:destroy) }
  it { should have_many(:users).dependent(:destroy) }
end
