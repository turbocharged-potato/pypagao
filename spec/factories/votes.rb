# frozen_string_literal: true

FactoryBot.define do
  factory :vote do
    score 1
    user nil
    answer nil
  end
end