# frozen_string_literal: true

class CreateCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :characters do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.belongs_to :race, null: false, foreign_key: true
      t.belongs_to :klass, null: false, foreign_key: true
      t.string :name, null: false, index: { unique: true }
      t.text :description
      t.integer :hp, null: false, default: 0
      t.timestamps
    end
  end
end
