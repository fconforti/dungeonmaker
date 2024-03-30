FactoryBot.define do
  factory :obstacle do
    account
    dungeon
    exit
    association :item, factory: :key
    sequence(:name) { |n| "obstacle #{n}" }
  end
end
