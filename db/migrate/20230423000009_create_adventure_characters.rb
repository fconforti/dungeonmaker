# frozen_string_literal: true

class CreateAdventureCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :adventure_characters do |t|
      t.belongs_to :adventure, null: false, foreign_key: true
      t.belongs_to :character, null: false, foreign_key: true
      t.timestamps
    end
  end
end
