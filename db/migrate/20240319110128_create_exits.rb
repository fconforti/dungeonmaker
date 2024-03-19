# frozen_string_literal: true

class CreateExits < ActiveRecord::Migration[7.0]
  def change
    create_table :exits do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.belongs_to :dungeon, null: false, foreign_key: true
      t.belongs_to :from_room, null: false, foreign_key: { to_table: :rooms }
      t.belongs_to :to_room, null: false, foreign_key: { to_table: :rooms }
      t.timestamps
    end
  end
end
