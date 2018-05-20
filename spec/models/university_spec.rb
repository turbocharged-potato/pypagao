# frozen_string_literal: true

require 'rails_helper'

RSpec.describe University, type: :model do
  it { should have_many(:courses).dependent(:destroy) }
  it { should have_many(:users).dependent(:destroy) }
end
