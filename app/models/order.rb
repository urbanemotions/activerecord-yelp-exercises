class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :restaurant
  has_many :dish_orders
  has_many :dishes, through: :dish_orders

  validates :customer, :restaurant, presence: true
  validates :dishes, length: {minimum: 1}
end
