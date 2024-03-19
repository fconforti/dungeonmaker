# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account do
  subject { build(:account) }

  describe 'associations' do
    it { is_expected.to have_many(:dungeons).inverse_of(:account) }
    it { is_expected.to have_many(:rooms).inverse_of(:account) }
    it { is_expected.to have_many(:exits).inverse_of(:account) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end
end
