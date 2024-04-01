require 'rails_helper'

RSpec.describe Inventory, type: :model do
  subject(:inventory) { build(:inventory) }

  describe 'associations' do
    it { is_expected.to belong_to(:account).inverse_of(:inventories) }
    it { is_expected.to belong_to(:character).inverse_of(:inventory) }
    it { is_expected.to have_many(:inventory_items).inverse_of(:inventory) }
  end
end
