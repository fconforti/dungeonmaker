# frozen_string_literal: true

class Pass < ApplicationRecord

  with_options inverse_of: :passes do
    belongs_to :account
    belongs_to :dungeon
    belongs_to :character
    belongs_to :obstacle
  end
    
end
