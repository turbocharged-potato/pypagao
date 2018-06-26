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

class University < ApplicationRecord
  has_many :courses, dependent: :destroy
  has_many :users, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :domain, presence: true, uniqueness: { case_sensitive: false }

  before_save :downcase_domain

  def downcase_domain
    self.domain = domain&.downcase
  end
end
