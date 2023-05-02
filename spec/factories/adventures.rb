# frozen_string_literal: true

FactoryBot.define do
  factory :adventure do
    sequence(:name) { |n| "adventure #{n}" }
  end
end
