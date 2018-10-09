class AddDishCountToTags < ActiveRecord::Migration
  def change
    add_column :tags, :dish_count, :integer, :default => 0, :null => false
  end
end
