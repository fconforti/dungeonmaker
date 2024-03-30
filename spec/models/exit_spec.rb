# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Exit do
  subject do
    build(:exit, dungeon:, from_room:, to_room:, account:, direction: 'north')
  end

  let!(:account) { create(:account) }
  let!(:dungeon) { create(:dungeon, account:) }
  let!(:from_room) { create(:room, dungeon:, account:) }
  let!(:to_room) { create(:room, dungeon:, account:) }

  describe 'associations' do
    it { is_expected.to belong_to(:from_room).class_name('Room').inverse_of(:exits) }
    it { is_expected.to belong_to(:to_room).class_name('Room').inverse_of(:entrances) }
    it { is_expected.to have_many(:obstacles).class_name('Obstacle').inverse_of(:exit) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:direction) }
    it { is_expected.to validate_inclusion_of(:direction).in_array(Exit::DIRECTIONS) }

    context 'with an existing exit in the same from room and direction' do
      let!(:exit) { create(:exit, dungeon:, from_room:, direction: 'north', account:) }

      before do
        subject.valid?
      end

      it 'is expected to be invalid (overlaps with an existing exit)' do
        expect(subject.errors[:direction]).to include("overlaps with an existing exit in #{from_room.name}")
      end
    end

    context 'with an existing entrance in the same from room and inverted direction' do
      let!(:exit) { create(:exit, dungeon:, to_room: from_room, direction: 'south', account:) }

      before do
        subject.valid?
      end

      it 'is expected to be invalid (overlaps with an existing entrance)' do
        expect(subject.errors[:direction]).to include("overlaps with an existing entrance in #{from_room.name}")
      end
    end

    context 'with an existing exit in the same to room and inverted direction' do
      let!(:exit) { create(:exit, dungeon:, from_room: to_room, direction: 'south', account:) }

      before do
        subject.valid?
      end

      it 'is expected to be invalid (overlaps with an existing exit)' do
        expect(subject.errors[:direction]).to include("overlaps with an existing exit in #{to_room.name}")
      end
    end

    context 'with an existing entrance in the same to room and direction' do
      let!(:exit) { create(:exit, dungeon:, to_room:, direction: 'north', account:) }

      before do
        subject.valid?
      end

      it 'is expected to be invalid (overlaps with an existing entrance)' do
        expect(subject.errors[:direction]).to include("overlaps with an existing entrance in #{to_room.name}")
      end
    end
  end
end
