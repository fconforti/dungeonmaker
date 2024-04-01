class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.belongs_to :character, null: false, foreign_key: true
      t.timestamps
    end
  end
end
