# frozen_string_literal: true

class Klass < ApplicationRecord
  HIT_DIES = %w[d6 d10 d12 d20].freeze

  with_options inverse_of: :klass, dependent: :restrict_with_exception do
    has_many :klass_abilities
    has_many :characters
  end

  validates :name, presence: true, uniqueness: true

  validates :hit_die, presence: true,
                      inclusion: HIT_DIES

  def hit_die_sides
    hit_die[1..].to_i
  end
end
