# frozen_string_literal: true

class CreateCharacterAbilities < ActiveRecord::Migration[7.0]
  def change
    create_table :character_abilities do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.belongs_to :character, null: false, foreign_key: true
      t.belongs_to :ability, null: false, foreign_key: true
      t.integer :score, null: false, default: 0
      t.timestamps
    end
  end
end
