# frozen_string_literal: true

FactoryBot.define do
  factory :klass do
    sequence(:name) { |n| "klass #{n}" }
    hit_die { 'd10' }
  end
end
