# frozen_string_literal: true

class CharacterAbility < ApplicationRecord
  ABILITY_DICE_STRING = '4d6 k3'

  with_options inverse_of: :character_abilities do
    belongs_to :account
    belongs_to :character
    belongs_to :ability
  end

  validates :score,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def resolve
    update score: dice_roll + ability_modifier(dice_roll) + race_increase
  end

  private

  def dice_roll
    @dice_roll ||= DiceBag::Roll.new(ABILITY_DICE_STRING).result.total
  end

  def ability_modifier(dice_roll)
    ((dice_roll - 10) / 2).round
  end

  def race_increase
    race_ability = character.race.race_abilities.where(ability:).first
    race_ability&.score_increase || 0
  end
end
