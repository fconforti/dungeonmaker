# frozen_string_literal: true

class CreateKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :keys do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.belongs_to :dungeon, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.timestamps
      t.index [:name, :dungeon_id], unique: true
    end
  end
end
