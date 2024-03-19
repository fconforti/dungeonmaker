# frozen_string_literal: true

class Account < ApplicationRecord
  include Print

  with_options inverse_of: :account, dependent: :restrict_with_exception do
    has_many :characters
    has_many :character_abilities
    has_many :dungeons
    has_many :rooms
    has_many :exits
  end

  validates :email, presence: true, uniqueness: true
  has_secure_password
end
