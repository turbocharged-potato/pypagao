# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should belong_to :paper }
  it { should have_many(:answers).dependent(:destroy) }
end
