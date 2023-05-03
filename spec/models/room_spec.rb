# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Room do
  subject { build(:room) }

  describe 'associations' do
    it { is_expected.to belong_to(:dungeon).inverse_of(:rooms) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
