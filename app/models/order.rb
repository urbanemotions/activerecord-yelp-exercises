class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :restaurant
  has_many :dish_orders
  has_many :dishes, through: :dish_orders
end
