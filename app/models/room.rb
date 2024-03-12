# frozen_string_literal: true

class Room < ApplicationRecord
  with_options inverse_of: :rooms do
    belongs_to :account
    belongs_to :dungeon
  end

  validates :name, presence: true, uniqueness: true
end
