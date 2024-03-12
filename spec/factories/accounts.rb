# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    sequence(:email) { |n| "account_#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
