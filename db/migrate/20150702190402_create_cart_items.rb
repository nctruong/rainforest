class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :product_id
      t.integer :user_id
      t.float :unit_price

      t.timestamps null: false
    end
    add_index :cart_items, [:product_id, :user_id]
  end
end
