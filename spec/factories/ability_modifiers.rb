# frozen_string_literal: true

FactoryBot.define do
  factory :ability_modifier do
    ruleset
    score_min { 10 }
    score_max { 20 }
    score_modifier { 0 }
  end
end
