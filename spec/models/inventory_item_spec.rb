require 'rails_helper'

RSpec.describe InventoryItem, type: :model do
  subject(:inventory_item) { build(:inventory_item) }

  describe 'associations' do
    it { is_expected.to belong_to(:account).inverse_of(:inventory_items) }
    it { is_expected.to belong_to(:inventory).inverse_of(:inventory_items) }
    it { is_expected.to belong_to(:item).inverse_of(:inventory_items) }
  end
end
