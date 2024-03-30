# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Room do
  subject { build(:room) }

  describe 'associations' do
    it { is_expected.to belong_to(:account).inverse_of(:rooms) }
    it { is_expected.to belong_to(:dungeon).inverse_of(:rooms) }
    it { is_expected.to have_many(:exits).inverse_of(:from_room).with_foreign_key(:from_room_id) }
    it { is_expected.to have_many(:entrances).class_name('Exit').inverse_of(:to_room).with_foreign_key(:to_room_id) }
    it { is_expected.to have_many(:characters).through(:character_positions) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:dungeon_id) }
  end
end
