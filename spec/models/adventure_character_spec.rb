# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdventureCharacter do
  subject { build(:adventure_character) }

  describe 'associations' do
    it { is_expected.to belong_to(:adventure).inverse_of(:adventure_characters) }
    it { is_expected.to belong_to(:character).inverse_of(:adventure_characters) }
  end
end
