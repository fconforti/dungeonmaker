# frozen_string_literal: true

FactoryBot.define do
  factory :character_position do
    account
    character
    dungeon
    room
  end
end
