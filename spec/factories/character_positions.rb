# frozen_string_literal: true

FactoryBot.define do
  factory :character_position do
    character
    dungeon
    room
  end
end
