require 'rails_helper'

RSpec.describe Pass, type: :model do
  subject(:pass) { build(:pass) }

  describe 'associations' do
    it { is_expected.to belong_to(:account).inverse_of(:passes) }
    it { is_expected.to belong_to(:dungeon).inverse_of(:passes) }
    it { is_expected.to belong_to(:character).inverse_of(:passes) }
    it { is_expected.to belong_to(:obstacle).inverse_of(:passes) }
  end
end
