# frozen_string_literal: true

class Character < ApplicationRecord
  include Print

  before_create :resolve_hp
  with_options inverse_of: :characters do
    belongs_to :race
    belongs_to :klass
  end

  with_options inverse_of: :character, dependent: :restrict_with_exception do
    has_many :character_abilities
  end

  validates :name, presence: true, uniqueness: true

  validates :hp,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def resolve_abilities
    ensure_abilities
    character_abilities.each(&:resolve)
  end

  # max hp are determined by the highest roll of the character's class hit die
  # plus the Constitution ability score modifier
  def resolve_hp
    self.hp = klass.hit_die_sides
  end

  private

  def ensure_abilities
    Ability.all.find_each do |ability|
      character_abilities.where(ability:).first_or_create!
    end
  end
end
