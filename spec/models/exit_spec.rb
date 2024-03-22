# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Exit do
  let!(:account) { create :account }
  let!(:dungeon) { create :dungeon, account: account }
  let!(:from_room) { create :room, dungeon: dungeon, account: account }
  let!(:to_room) { create :room, dungeon: dungeon, account: account }

  subject { build :exit, dungeon: dungeon, from_room: from_room, to_room: to_room, account: account, from_direction: 'north', to_direction: 'south' }

  describe 'associations' do
    it { is_expected.to belong_to(:from_room).class_name('Room').inverse_of(:exits) }
    it { is_expected.to belong_to(:to_room).class_name('Room').inverse_of(:entrances) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:from_direction) }
    it { is_expected.to validate_presence_of(:to_direction) }
    it { is_expected.to validate_inclusion_of(:from_direction).in_array(Exit::DIRECTIONS) }
    it { is_expected.to validate_inclusion_of(:to_direction).in_array(Exit::DIRECTIONS) }

    context "with an existing exit in the same from room and from direction" do
      let!(:exit) { create :exit, dungeon: dungeon, from_room: from_room, from_direction: 'north', account: account }

      before do
        subject.valid?        
      end

      it "is expected to be invalid (overlaps with an existing exit)" do
        expect(subject.errors[:from_direction]).to include("overlaps with an existing exit in #{from_room.name}")
      end
    end

    context "with an existing entrance in the same from room and from direction" do
      let!(:exit) { create :exit, dungeon: dungeon, to_room: from_room, to_direction: 'north', account: account }

      before do
        subject.valid?        
      end

      it "is expected to be invalid (overlaps with an existing entrance)" do
        expect(subject.errors[:from_direction]).to include("overlaps with an existing entrance in #{from_room.name}")
      end
    end

    context "with an existing entrance in the same to room and to direction" do
      let!(:exit) { create :exit, dungeon: dungeon, to_room: to_room, to_direction: 'south', account: account }

      before do
        subject.valid?        
      end

      it "is expected to be invalid (overlaps with an existing entrance)" do
        expect(subject.errors[:to_direction]).to include("overlaps with an existing entrance in #{to_room.name}")
      end
    end

    context "with an existing exit in the same to room and to direction" do
      let!(:exit) { create :exit, dungeon: dungeon, from_room: to_room, from_direction: 'south', account: account }

      before do
        subject.valid?        
      end

      it "is expected to be invalid (overlaps with an existing exit)" do
        expect(subject.errors[:to_direction]).to include("overlaps with an existing exit in #{to_room.name}")
      end
    end


  end
end
