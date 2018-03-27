class AddDefaultInventoryToVinyl < ActiveRecord::Migration[5.1]
  def change
    change_column :vinyls, :inventory, :integer, :default => 1
  end
end
