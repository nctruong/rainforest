class ChangePriceNameType < ActiveRecord::Migration
  def self.up
    change_column :products, :price_in_cents, :float
  end

  def self.down
    change_column :products, :price_in_cents, :integer
  end
end
