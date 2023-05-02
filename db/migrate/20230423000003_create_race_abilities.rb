# frozen_string_literal: true

class CreateRaceAbilities < ActiveRecord::Migration[7.0]
  def change
    create_table :race_abilities do |t|
      t.belongs_to :race, null: false, foreign_key: true
      t.belongs_to :ability, null: false, foreign_key: true
      t.integer :score_increase, null: false, default: 0
      t.timestamps
    end
  end
end
