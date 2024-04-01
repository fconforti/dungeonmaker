class CreateInventoryItems < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_items do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.belongs_to :inventory, null: false, foreign_key: true
      t.belongs_to :item, null: false, polymorphic: true
      t.integer :quantity, null: false, default: 1
      t.timestamps
    end
  end
end
