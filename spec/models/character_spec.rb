# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Character do
  subject(:character) { create(:character) }

  it 'is expected to set the hp as its klass hit die sides' do
    expect(character.hp).to eq(10)
  end

  describe 'associations' do
    it { is_expected.to belong_to(:account).inverse_of(:characters) }
    it { is_expected.to belong_to(:race).inverse_of(:characters) }
    it { is_expected.to belong_to(:klass).inverse_of(:characters) }
    it { is_expected.to have_many(:character_abilities).inverse_of(:character) }
    it { is_expected.to have_one(:position).class_name('CharacterPosition').inverse_of(:character) }
    it { is_expected.to have_many(:passes).inverse_of(:character) }
    it { is_expected.to have_one(:inventory).inverse_of(:character) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_numericality_of(:hp).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe '#resolve_abilities' do
    before do
      %w[Strength Dexterity Wisdom].each { |name| create(:ability, name:) }
      stub_dice_roll('4d6 k3', 15)
      character.resolve_abilities
    end

    it 'is expected to ensure character abilities' do
      expect(character.character_abilities.count).to eq(3)
    end

    it 'is expected to resolve all character abilities' do
      character.character_abilities.each do |character_ability|
        expect(character_ability.score).to eq(17)
      end
    end
  end
end
