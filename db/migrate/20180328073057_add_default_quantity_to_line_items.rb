class AddDefaultQuantityToLineItems < ActiveRecord::Migration[5.1]
  def change
    change_column :line_items, :quantity, :integer, :default => 1
  end
end
