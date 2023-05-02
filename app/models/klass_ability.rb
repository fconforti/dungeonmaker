# frozen_string_literal: true

class KlassAbility < ApplicationRecord
  with_options inverse_of: :klass_abilities do
    belongs_to :klass
    belongs_to :ability
  end
end
