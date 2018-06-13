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

class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy
  belongs_to :university
end
