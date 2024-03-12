# frozen_string_literal: true

class Dungeon < ApplicationRecord
  include Print

  with_options inverse_of: :dungeons do
    belongs_to :account
  end

  with_options inverse_of: :dungeon, dependent: :restrict_with_exception do
    has_many :rooms
  end

  validates :name, presence: true, uniqueness: true
end
