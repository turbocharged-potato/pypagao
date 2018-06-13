# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  paper_id   :bigint(8)
#
# Indexes
#
#  index_questions_on_paper_id  (paper_id)
#

FactoryBot.define do
  factory :question do
    name 'MyString'
    paper
  end
end
