# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RaceAbility do
  subject { build(:race_ability) }

  describe 'associations' do
    it { is_expected.to belong_to(:race).inverse_of(:race_abilities) }
    it { is_expected.to belong_to(:ability).inverse_of(:race_abilities) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:score_increase) }
    it { is_expected.to validate_numericality_of(:score_increase).only_integer.is_greater_than_or_equal_to(0) }
  end
end
