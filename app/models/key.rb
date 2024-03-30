class Key < ApplicationRecord
  include Print

  with_options inverse_of: :keys do
    belongs_to :account
    belongs_to :dungeon
  end

  with_options inverse_of: :item do
    has_many :exit_obstacles, as: :item
  end

  validates :name, presence: true, uniqueness: true
  
end
