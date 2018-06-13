# frozen_string_literal: true

# == Schema Information
#
# Table name: papers
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  semester_id :bigint(8)
#
# Indexes
#
#  index_papers_on_semester_id  (semester_id)
#

FactoryBot.define do
  factory :paper do
    name 'MyString'
    question ''
  end
end
