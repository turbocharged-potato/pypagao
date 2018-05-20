# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Paper, type: :model do
  it { should belong_to :semester }
  it { should have_many(:questions).dependent(:destroy) }
end
