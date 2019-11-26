class CreateDishes < ActiveRecord::Migration[4.2]
  def change
    create_table :dishes do |t|
      t.string :name
      t.references :restaurant
    end
  end
end
