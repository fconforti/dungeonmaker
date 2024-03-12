# frozen_string_literal: true

FactoryBot.define do
  factory :character do
    account
    race
    klass
    sequence(:name) { |n| "character #{n}" }
    hp { 10 }
  end
end
