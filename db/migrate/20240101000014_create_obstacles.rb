# frozen_string_literal: true

class CreateObstacles < ActiveRecord::Migration[7.0]
  def change
    create_table :obstacles do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.belongs_to :dungeon, null: false, foreign_key: true
      t.belongs_to :exit, null: false, foreign_key: true
      t.belongs_to :item, null: false, polymorphic: true
      t.string :name, null: false
      t.text :description
      t.timestamps
      t.index [:name, :exit_id], unique: true
    end
  end
end
