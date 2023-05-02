# frozen_string_literal: true

class Ability < ApplicationRecord
  with_options inverse_of: :ability, dependent: :restrict_with_exception do
    has_many :race_abilities
    has_many :klass_abilities
    has_many :character_abilities
  end

  validates :name, presence: true, uniqueness: true
end
