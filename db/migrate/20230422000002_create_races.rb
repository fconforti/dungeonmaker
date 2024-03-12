# frozen_string_literal: true

class CreateRaces < ActiveRecord::Migration[7.0]
  def change
    create_table :races do |t|
      t.string :name, null: false, index: { unique: true }
      t.text :description
      t.timestamps
    end
  end
end
