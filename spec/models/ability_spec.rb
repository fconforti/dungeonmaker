# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ability do
  subject { build(:ability) }

  describe 'associations' do
    it { is_expected.to have_many(:klass_abilities).inverse_of(:ability) }
    it { is_expected.to have_many(:character_abilities).inverse_of(:ability) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
