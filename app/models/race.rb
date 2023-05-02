# frozen_string_literal: true

class Race < ApplicationRecord
  with_options inverse_of: :race, dependent: :restrict_with_exception do
    has_many :race_abilities
    has_many :characters
  end

  validates :name, presence: true, uniqueness: true
end
