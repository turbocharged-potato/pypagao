# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Semester, type: :model do
  it { should belong_to :course }
  it { should have_many(:papers).dependent(:destroy) }
end
