# frozen_string_literal: true

class Room < ApplicationRecord
  include Print

  with_options inverse_of: :rooms do
    belongs_to :account
    belongs_to :dungeon
  end

  with_options inverse_of: :from_room, dependent: :restrict_with_exception do
    has_many :exits, foreign_key: :from_room_id
  end

  with_options inverse_of: :to_room, dependent: :restrict_with_exception do
    has_many :entrances, foreign_key: :to_room_id, class_name: 'Exit'
  end

  validates :name, presence: true, uniqueness: true
end
