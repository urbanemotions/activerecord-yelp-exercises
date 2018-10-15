class CreateDishOrders < ActiveRecord::Migration
  def change
    create_table :dish_orders do |t|
      t.integer :dish_id
      t.integer :order_id
    end
  end
end
