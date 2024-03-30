FactoryBot.define do
  factory :exit_obstacle do
    account
    dungeon
    exit
    association :item, factory: :key
  end
end
