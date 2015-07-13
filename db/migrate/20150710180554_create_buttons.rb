class CreateButtons < ActiveRecord::Migration
  def change
    create_table :buttons do |t|
      t.string :core_id
      t.string :access_token
      t.integer :user_id
      t.integer :product_id

      t.timestamps null: false
    end
    add_index :buttons, [:user_id, :product_id]
  end
end
