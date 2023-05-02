# frozen_string_literal: true

class AdventureCharacter < ApplicationRecord
  with_options inverse_of: :adventure_characters do
    belongs_to :adventure
    belongs_to :character
  end
end
