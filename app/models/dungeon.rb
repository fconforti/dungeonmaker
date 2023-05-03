# frozen_string_literal: true

class Dungeon < ApplicationRecord
  with_options inverse_of: :dungeon, dependent: :restrict_with_exception do
    has_many :rooms
  end

  validates :name, presence: true, uniqueness: true
end
