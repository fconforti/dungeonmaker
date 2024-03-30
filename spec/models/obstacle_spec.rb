require 'rails_helper'

RSpec.describe Obstacle, type: :model do
  subject(:obstacle) { build(:obstacle) }

  describe 'associations' do
    it { is_expected.to belong_to(:account).inverse_of(:obstacles) }
    it { is_expected.to belong_to(:dungeon).inverse_of(:obstacles) }
    it { is_expected.to belong_to(:exit).inverse_of(:obstacles) }
    it { is_expected.to belong_to(:item).inverse_of(:obstacles) }
    it { is_expected.to have_many(:passes).inverse_of(:obstacle) }
  end

  describe 'validations' do
    it { is_expected.to validate_inclusion_of(:item_type).in_array(Obstacle::ITEM_TYPES) }
  end
end
