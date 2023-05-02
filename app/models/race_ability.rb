# frozen_string_literal: true

class RaceAbility < ApplicationRecord
  with_options inverse_of: :race_abilities do
    belongs_to :race
    belongs_to :ability
  end

  validates :score_increase,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
