# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  it { should belong_to :university }
  it { should have_many(:semesters).dependent(:destroy) }
end
