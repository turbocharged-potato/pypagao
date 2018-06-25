# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  name            :string           not null
#  password_digest :string           not null
#  token           :string
#  verified        :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  university_id   :bigint(8)
#
# Indexes
#
#  index_users_on_token          (token) UNIQUE
#  index_users_on_university_id  (university_id)
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }
  it { should belong_to :university }
  it { should have_secure_password }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name) }

  it 'should downcase email' do
    email = 'Anu@example.com'
    user = create(:user, email: email)
    expect(User.find(user.id).email).to eq(email.downcase)
  end

  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end
end
