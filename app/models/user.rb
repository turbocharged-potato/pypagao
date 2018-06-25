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

class User < ApplicationRecord
  has_secure_password
  has_secure_token
  has_many :comments, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy
  belongs_to :university

  validates :email, presence: true
  validates :name, presence: true

  before_save :downcase_email

  def downcase_email
    self.email = email.downcase
  end
end
