# frozen_string_literal: true

class Adventure < ApplicationRecord
  with_options inverse_of: :adventure, dependent: :restrict_with_exception do
    has_many :adventure_characters
  end

  validates :name, presence: true, uniqueness: true
end
