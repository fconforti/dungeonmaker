# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.timestamps
    end
  end
end
