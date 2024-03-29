# frozen_string_literal: true

FactoryBot.define do
  factory :key do
    account
    dungeon
    sequence(:name) { |n| "room #{n}" }
  end
end