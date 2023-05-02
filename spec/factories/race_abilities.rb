# frozen_string_literal: true

FactoryBot.define do
  factory :race_ability do
    race
    ability
    score_increase { 2 }
  end
end
