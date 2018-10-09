class DishTag < ActiveRecord::Base
  belongs_to :dish, counter_cache: :tag_count
  belongs_to :tag, counter_cache: :dish_count

  validates :tag_id, uniqueness: { scope: :dish_id }
end
