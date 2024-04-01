# frozen_string_literal: true

class Inventory < ApplicationRecord

  with_options inverse_of: :inventories do
    belongs_to :account
  end

  with_options inverse_of: :inventory do
    belongs_to :character
    has_many :inventory_items
  end
end
