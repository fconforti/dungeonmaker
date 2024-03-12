# frozen_string_literal: true

FactoryBot.define do
  factory :character_ability do
    account
    character
    ability
  end
end
