class User < ApplicationRecord
  include Print

  validates :name, presence: true, uniqueness: true
  has_secure_password

end
