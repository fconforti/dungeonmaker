# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CharacterPosition do
  subject(:character_ability) { build(:character_position) }

  describe 'associations' do
    it { is_expected.to belong_to(:character).inverse_of(:position) }
    it { is_expected.to belong_to(:dungeon).inverse_of(:character_positions) }
    it { is_expected.to belong_to(:room).inverse_of(:character_positions) }
  end
end
