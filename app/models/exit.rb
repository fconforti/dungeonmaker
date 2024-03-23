# frozen_string_literal: true

class Exit < ApplicationRecord
  include Print

  NORTH='north'
  EAST='east'
  SOUTH='south'
  WEST='west'

  DIRECTIONS=[NORTH,EAST,SOUTH,WEST].freeze

  INVERTED_DIRECTIONS={
    NORTH => SOUTH,
    EAST => WEST,
    SOUTH => NORTH,
    WEST => EAST
  }.freeze

  def name
    "From #{from_room.name} to #{to_room.name}"
  end

  with_options inverse_of: :exits do
    belongs_to :account
    belongs_to :dungeon
    belongs_to :from_room, class_name: 'Room'
  end

  with_options inverse_of: :entrances do
    belongs_to :to_room, class_name: 'Room'
  end

  validates :direction, presence: true, inclusion: { in: DIRECTIONS }
  
  validate :no_from_room_exit, if: :from_room
  validate :no_from_room_entrance, if: :from_room
  validate :no_to_room_exit, if: :to_room
  validate :no_to_room_entrance, if: :to_room

  private
  def no_from_room_exit
    if from_room.exits.exists?(direction: direction)
      errors.add(:direction, "overlaps with an existing exit in #{from_room.name}")
    end
  end

  def no_from_room_entrance
    if from_room.entrances.exists?(direction: INVERTED_DIRECTIONS[direction])
      errors.add(:direction, "overlaps with an existing entrance in #{from_room.name}")
    end
  end

  def no_to_room_exit
    if to_room.exits.exists?(direction: INVERTED_DIRECTIONS[direction])
      errors.add(:direction, "overlaps with an existing exit in #{to_room.name}")
    end
  end

  def no_to_room_entrance
    if to_room.entrances.exists?(direction: direction)
      errors.add(:direction, "overlaps with an existing entrance in #{to_room.name}")
    end
  end

end
