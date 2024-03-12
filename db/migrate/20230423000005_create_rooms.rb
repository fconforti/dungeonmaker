# frozen_string_literal: true

class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.belongs_to :dungeon, null: false, foreign_key: true
      t.string :name, null: false, index: { unique: true }
      t.text :description
      t.timestamps
    end
  end
end
