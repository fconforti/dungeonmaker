# frozen_string_literal: true

FactoryBot.define do
  factory :dungeon do
    sequence(:name) { |n| "dungeon #{n}" }
  end
end
