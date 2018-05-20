# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to :user }
  it { should belong_to :answer }
end
