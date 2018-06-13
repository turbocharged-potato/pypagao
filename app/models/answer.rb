# frozen_string_literal: true

# == Schema Information
#
# Table name: answers
#
#  id          :bigint(8)        not null, primary key
#  content     :string
#  imgur       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint(8)
#  user_id     :bigint(8)
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#  index_answers_on_user_id      (user_id)
#

class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
end
