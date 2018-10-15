class AddLonToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :lon, :integer
  end
end
