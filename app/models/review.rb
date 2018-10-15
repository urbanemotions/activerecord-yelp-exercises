class Review < ActiveRecord::Base
  belongs_to :customer
  belongs_to :restaurant

  validates :restaurant, presence: true
  validates :content, presence: true, length: {minimum: 10}
  validates :rating, presence: true, inclusion: {in: 1..5}

  validate  :customer, :customer_validator

  private

  def customer_validator
    if customer == nil
      errors.add(:customer, "must be present")
    elsif !customer.restaurants.include?(restaurant)
      errors.add(:customer, "must have made an order at this restaurant")
    end
  end
end
