require 'rails_helper'

RSpec.describe ExitObstacle, type: :model do
  subject(:exit_obstacle) { build(:exit_obstacle) }

  describe 'associations' do
    it { is_expected.to belong_to(:account).inverse_of(:exit_obstacles) }
    it { is_expected.to belong_to(:dungeon).inverse_of(:exit_obstacles) }
    it { is_expected.to belong_to(:exit).inverse_of(:obstacles) }
    it { is_expected.to belong_to(:item).inverse_of(:exit_obstacles) }
  end

  describe 'validations' do
    it { is_expected.to validate_inclusion_of(:item_type).in_array(ExitObstacle::ITEM_TYPES) }
  end
end
