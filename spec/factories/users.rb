# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name 'MyString'
    email 'MyString'
    password_digest 'MyString'
    answer ''
    comment ''
  end
end
