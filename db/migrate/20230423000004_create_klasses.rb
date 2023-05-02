# frozen_string_literal: true

class CreateKlasses < ActiveRecord::Migration[7.0]
  def change
    create_table :klasses do |t|
      t.string :name, null: false, index: { unique: true }
      t.text :description
      t.timestamps
      t.string :hit_die, null: false
    end
  end
end
