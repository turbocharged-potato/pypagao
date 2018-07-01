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

FactoryBot.define do
  factory :user do
    name 'John'
    sequence(:email) { |n| "anu#{n}@example.com" }
    password '123456'
    university
    verified true
  end
end
