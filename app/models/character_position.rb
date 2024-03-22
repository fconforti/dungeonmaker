# frozen_string_literal: true

class CharacterPosition < ApplicationRecord
  include Print

  with_options inverse_of: :position do
    belongs_to :character
  end

  with_options inverse_of: :character_positions do
    belongs_to :account
    belongs_to :dungeon
    belongs_to :room
  end
end
