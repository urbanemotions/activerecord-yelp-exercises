class Dish < ActiveRecord::Base
  belongs_to :restaurant
  has_many :dish_tags
  has_many :tags, through: :dish_tags

  scope :with_tag, -> (name) { joins(:tags).merge(Tag.with_name(name)) }
  scope :without_tag, -> (name) { where.not(id: with_tag(name)) }
  scope :vegetarian, -> { with_tag("vegetarian") }
  scope :non_veggie, -> { without_tag("vegetarian") }
  scope :names, -> { pluck(:name) }
  scope :max_tags, -> { joins(:dish_tags).group(:dish_id).order("COUNT(dish_id) DESC").take }
  scope :tagged, -> { joins(:tags) }
  scope :untagged, -> { where.not(id: tagged) }
  scope :average_tag_count, -> { average(:tag_count) }

  validates :name, presence: true
  validates :restaurant, presence: true
  validates_associated :dish_tags

end
