# frozen_string_literal: true

class CharacterPosition < ApplicationRecord

  with_options inverse_of: :position do
    belongs_to :character
  end

  with_options inverse_of: :character_positions do  
    belongs_to :dungeon
    belongs_to :room
  end

end
