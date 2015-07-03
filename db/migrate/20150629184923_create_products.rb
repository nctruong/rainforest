class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.float :price
      t.boolean :bought?, default: false
      t.integer :seller_id

      t.timestamps null: false
    end
    add_index :products, :seller_id
  end
end
