# frozen_string_literal: true

class Key < ApplicationRecord
  include Print

  with_options inverse_of: :keys do
    belongs_to :account
    belongs_to :dungeon
  end

  with_options inverse_of: :item do
    has_many :obstacles, as: :item
    has_many :inventory_items, as: :item
  end

  validates :name, presence: true, uniqueness: true
  
end
