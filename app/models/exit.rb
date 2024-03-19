# frozen_string_literal: true

class Exit < ApplicationRecord
  include Print

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
end
