# frozen_string_literal: true

FactoryBot.define do
  factory :race do
    sequence(:name) { |n| "race #{n}" }
  end
end
