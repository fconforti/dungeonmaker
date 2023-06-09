# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dungeon do
  subject { build(:dungeon) }

  describe 'associations' do
    it { is_expected.to have_many(:rooms).inverse_of(:dungeon) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
