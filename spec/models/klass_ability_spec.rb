# frozen_string_literal: true

require 'rails_helper'

RSpec.describe KlassAbility do
  subject { build(:klass_ability) }

  describe 'associations' do
    it { is_expected.to belong_to(:klass).inverse_of(:klass_abilities) }
    it { is_expected.to belong_to(:ability).inverse_of(:klass_abilities) }
  end
end
