class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :product_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :reviews, [:product_id, :user_id]
  end
end
