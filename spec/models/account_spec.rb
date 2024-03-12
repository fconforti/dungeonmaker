# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account do
  subject { build(:account) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end
end
