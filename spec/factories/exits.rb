# frozen_string_literal: true

FactoryBot.define do
  factory :exit do
    account
    dungeon
    association :from_room, factory: :room
    association :to_room, factory: :room
    from_direction { 'north' }
    to_direction { 'south' }
  end
end
