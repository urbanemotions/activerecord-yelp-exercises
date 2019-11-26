class AddPriceToDishes < ActiveRecord::Migration[4.2]
  def change
    add_column :dishes, :price, :float
  end
end
