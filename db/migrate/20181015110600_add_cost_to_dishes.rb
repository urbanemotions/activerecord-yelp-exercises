class AddCostToDishes < ActiveRecord::Migration[4.2]
  def change
    add_column :dishes, :cost, :float
  end
end
