class DishOrder < ActiveRecord::Base
  validate :restaurants_match

  belongs_to :dish
  belongs_to :order

  private

  def restaurants_match
    if dish.restaurant != order.restaurant
      errors.add(:dish, "dish and order must be from the same restaurant")
    end
  end
end
