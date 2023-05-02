# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Klass do
  subject(:klass) { build(:klass) }

  describe 'associations' do
    it { is_expected.to have_many(:klass_abilities).inverse_of(:klass) }
    it { is_expected.to have_many(:characters).inverse_of(:klass) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:hit_die) }
    it { is_expected.to validate_inclusion_of(:hit_die).in_array(Klass::HIT_DIES) }
  end

  {
    'd6' => 6,
    'd10' => 10
  }.each do |k, v|
    describe "#hit_die_sides (#{k})" do
      before { klass.hit_die = k }

      it "is expected to return #{v} sides" do
        expect(klass.hit_die_sides).to eq(v)
      end
    end
  end
end
