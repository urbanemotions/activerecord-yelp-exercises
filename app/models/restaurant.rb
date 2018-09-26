class Restaurant < ActiveRecord::Base
  has_many :dishes

  validates :name, presence: true

  def self.mcdonalds
    Restaurant.find_by(:name => "McDonalds")
  end

  def self.tenth
    begin
      Restaurant.find(10)
    rescue ActiveRecord::RecordNotFound => e
      nil
    end
  end

  def self.with_long_names
    where('length(name) > 12')
  end

  def self.focused
    Dish.group("restaurant_id").count
        .select { |restaurant_id, dish_count| dish_count < 5 }
        .map    { |restaurant_id, dish_count| Restaurant.find(restaurant_id) }
  end

  def self.large_menu
    Dish.group("restaurant_id").count
        .select { |restaurant_id, dish_count| dish_count > 20 }
        .map    { |restaurant_id, dish_count| Restaurant.find(restaurant_id) }
  end
end
