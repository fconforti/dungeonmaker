# frozen_string_literal: true

FactoryBot.define do
  factory :dungeon do
    account
    sequence(:name) { |n| "dungeon #{n}" }
  end
end
