# frozen_string_literal: true

class Exit < ApplicationRecord
  include Print

  DIRECTIONS=%w[north east south west].freeze

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

  validates :from_direction, presence: true, inclusion: { in: DIRECTIONS }
  validates :to_direction, presence: true, inclusion: { in: DIRECTIONS }
  validate :from_direction_doesn_not_overlap, if: :from_room
  validate :to_direction_doesn_not_overlap, if: :to_room

  private
  def from_direction_doesn_not_overlap

    if from_room.exits.exists?(from_direction: from_direction)
      errors.add(:from_direction, "overlaps with an existing exit in #{from_room.name}")
    elsif from_room.entrances.exists?(to_direction: from_direction)
      errors.add(:from_direction, "overlaps with an existing entrance in #{from_room.name}")
    end
  end

  def to_direction_doesn_not_overlap
    if to_room.entrances.exists?(to_direction: to_direction)
      errors.add(:to_direction, "overlaps with an existing entrance in #{to_room.name}")
    elsif to_room.exits.exists?(from_direction: to_direction)
      errors.add(:to_direction, "overlaps with an existing exit in #{to_room.name}")
    end
  end

end
