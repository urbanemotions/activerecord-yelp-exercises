class DishTag < ActiveRecord::Base
  belongs_to :dish
  belongs_to :tag

  validates :tag_id, uniqueness: { scope: :dish_id }
end
