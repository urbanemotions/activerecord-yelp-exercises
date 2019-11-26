class AddLonToRestaurants < ActiveRecord::Migration[4.2]
  def change
    add_column :restaurants, :lon, :integer
  end
end
