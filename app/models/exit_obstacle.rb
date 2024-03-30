class ExitObstacle < ApplicationRecord
  include Print

  ITEM_TYPES = %w[Key].freeze

  with_options inverse_of: :obstacles do
    belongs_to :exit
  end

  with_options inverse_of: :exit_obstacles do
    belongs_to :account
    belongs_to :dungeon
    belongs_to :item, polymorphic: true
  end

  validates :item_type, inclusion: { in: ITEM_TYPES }
  
end