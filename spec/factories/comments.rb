# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id         :bigint(8)        not null, primary key
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  answer_id  :bigint(8)
#  user_id    :bigint(8)
#
# Indexes
#
#  index_comments_on_answer_id  (answer_id)
#  index_comments_on_user_id    (user_id)
#

FactoryBot.define do
  factory :comment do
    content 'MyString'
  end
end
