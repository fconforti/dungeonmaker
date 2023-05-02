# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Race do
  subject { build(:race) }

  describe 'associations' do
    it { is_expected.to have_many(:characters).inverse_of(:race) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
