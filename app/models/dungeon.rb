# frozen_string_literal: true

class Dungeon < ApplicationRecord
  include Print

  with_options inverse_of: :dungeons do
    belongs_to :account
  end

  with_options inverse_of: :dungeon, dependent: :restrict_with_exception do
    has_many :rooms
    has_many :keys
    has_many :exits
    has_many :character_positions
    has_many :exit_obstacles    
  end

  validates :name, presence: true, uniqueness: true

  def base_room
    rooms.first
  end
end
