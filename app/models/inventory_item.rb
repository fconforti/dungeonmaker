# frozen_string_literal: true

class InventoryItem < ApplicationRecord

  with_options inverse_of: :inventory_items do
    belongs_to :account
    belongs_to :inventory
    belongs_to :item, polymorphic: true
  end

end
