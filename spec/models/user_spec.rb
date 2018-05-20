# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }
  it { should belong_to :university }
end
