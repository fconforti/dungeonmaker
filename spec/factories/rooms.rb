# frozen_string_literal: true

FactoryBot.define do
  factory :room do
    account
    dungeon
    sequence(:name) { |n| "dungeon #{n}" }
  end
end
