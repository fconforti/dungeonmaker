FactoryBot.define do
  factory :exit do
    account
    dungeon
    association :from_room, factory: :room
    association :to_room, factory: :room
  end
end
