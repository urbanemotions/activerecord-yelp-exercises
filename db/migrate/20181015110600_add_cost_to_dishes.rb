class AddCostToDishes < ActiveRecord::Migration
  def change
    add_column :dishes, :cost, :float
  end
end
