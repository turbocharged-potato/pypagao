# frozen_string_literal: true

# == Schema Information
#
# Table name: universities
#
#  id         :bigint(8)        not null, primary key
#  domain     :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_universities_on_domain  (domain) UNIQUE
#  index_universities_on_name    (name) UNIQUE
#

FactoryBot.define do
  factory :university do
    sequence(:name) { |n| "university#{n}" }
    sequence(:domain) { |n| "u#{n}.edu" }
  end
end
