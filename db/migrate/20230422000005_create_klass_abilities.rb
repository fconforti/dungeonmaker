# frozen_string_literal: true

class CreateKlassAbilities < ActiveRecord::Migration[7.0]
  def change
    create_table :klass_abilities do |t|
      t.belongs_to :klass, null: false, foreign_key: true
      t.belongs_to :ability, null: false, foreign_key: true
      t.timestamps
    end
  end
end
