# frozen_string_literal: true

FactoryBot.define do
  factory :ability do
    sequence(:name) { |n| "ability #{n}" }
  end
end
