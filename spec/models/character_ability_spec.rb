# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CharacterAbility do
  subject(:character_ability) { create(:character_ability) }

  describe 'associations' do
    it { is_expected.to belong_to(:character).inverse_of(:character_abilities) }
    it { is_expected.to belong_to(:ability).inverse_of(:character_abilities) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:score) }
    it { is_expected.to validate_numericality_of(:score).only_integer.is_greater_than_or_equal_to(0) }
  end

  {
    3 => 2,
    10 => 13,
    15 => 20,
    16 => 22,
    18 => 25
  }.each do |k, v|
    describe "#resolve (#{k})" do
      before do
        create(:race_ability, race: character_ability.character.race, ability: character_ability.ability,
                              score_increase: 3)
        stub_dice_roll('4d6 k3', k)
        character_ability.resolve
      end

      it "is expected to update the ability score (#{v})" do
        expect(character_ability.score).to eq(v)
      end
    end
  end
end
