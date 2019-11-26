class AddLatToRestaurants < ActiveRecord::Migration[4.2]
  def change
    add_column :restaurants, :lat, :integer
  end
end
