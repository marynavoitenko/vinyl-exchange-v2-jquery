class AddUserIdToVinyl < ActiveRecord::Migration[5.1]
  def change
    add_column :vinyls, :user_id, :integer
  end
end
