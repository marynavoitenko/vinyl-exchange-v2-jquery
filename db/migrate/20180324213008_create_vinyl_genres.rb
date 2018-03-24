class CreateVinylGenres < ActiveRecord::Migration[5.1]
  def change
    create_table :vinyl_genres do |t|
      t.integer :genre_id
      t.integer :vinyl_id

      t.timestamps
    end
  end
end
