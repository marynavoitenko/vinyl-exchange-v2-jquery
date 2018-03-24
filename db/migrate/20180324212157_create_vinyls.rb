class CreateVinyls < ActiveRecord::Migration[5.1]
  def change
    create_table :vinyls do |t|
      t.string :title
      t.integer :price
      t.integer :inventory
      t.boolean :for_sale, default: false
      t.integer :artist_id

      t.timestamps
    end
  end
end
