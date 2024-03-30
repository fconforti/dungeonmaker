# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Key do
  subject { build(:key) }

  describe 'associations' do
    it { is_expected.to belong_to(:account).inverse_of(:keys) }
    it { is_expected.to belong_to(:dungeon).inverse_of(:keys) }
    it { is_expected.to have_many(:obstacles).inverse_of(:item) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
