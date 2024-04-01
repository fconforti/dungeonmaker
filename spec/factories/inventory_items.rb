FactoryBot.define do
  factory :inventory_item do
    account
    inventory
    association :item, factory: :key
  end
end
