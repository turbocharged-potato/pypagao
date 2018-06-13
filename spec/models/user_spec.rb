# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string
#  name            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  university_id   :bigint(8)
#
# Indexes
#
#  index_users_on_university_id  (university_id)
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }
  it { should belong_to :university }
end
