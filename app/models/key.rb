class Key < ApplicationRecord
  include Print

  with_options inverse_of: :keys do
    belongs_to :account
    belongs_to :dungeon
  end

  with_options inverse_of: :key do
    has_one :exit
  end

  validates :name, presence: true, uniqueness: true
  
end
