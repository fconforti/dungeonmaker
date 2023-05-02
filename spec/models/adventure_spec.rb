# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Adventure do
  subject { build(:adventure) }

  describe 'associations' do
    it { is_expected.to have_many(:adventure_characters).inverse_of(:adventure) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
