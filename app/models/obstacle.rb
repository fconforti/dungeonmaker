# frozen_string_literal: true

class Obstacle < ApplicationRecord
  include Print

  ITEM_TYPES = %w[Key].freeze

  with_options inverse_of: :obstacles do
    belongs_to :account
    belongs_to :dungeon
    belongs_to :exit
    belongs_to :item, polymorphic: true
  end

  with_options inverse_of: :obstacle do
    has_many :passes
  end

  validates :item_type, inclusion: { in: ITEM_TYPES }
  
  scope :for_character, ->(character) do
    where.not(id: character.passes.map{|p| p.obstacle_id})
  end

end