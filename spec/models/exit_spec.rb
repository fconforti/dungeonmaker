# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Exit do
  subject { build(:exit) }

  describe 'associations' do
    it { is_expected.to belong_to(:from_room).class_name('Room').inverse_of(:exits) }
    it { is_expected.to belong_to(:to_room).class_name('Room').inverse_of(:entrances) }
  end
end
