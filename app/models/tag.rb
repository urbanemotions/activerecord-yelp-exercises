require 'pry'
class Tag < ActiveRecord::Base
  has_many :dish_tags
  has_many :dishes, through: :dish_tags
  has_many :restaurants, through: :dishes

  scope :with_name, -> (name) { where(name: name) }
  scope :used, -> { joins(:dish_tags).distinct }
  scope :unused, -> { where.not(id: used) }
  scope :grouped_by_tag_id, -> { joins(:dish_tags).group(:tag_id) }
  scope :ordered_by_popularity_desc, -> { grouped_by_tag_id.order("COUNT(dish_tags.dish_id) DESC") }
  scope :ordered_by_popularity_asc, -> { grouped_by_tag_id.order("COUNT(dish_tags.dish_id) ASC") }
  scope :most_common, -> { ordered_by_popularity_desc.take }
  scope :least_common, -> { ordered_by_popularity_asc.take }
  scope :uncommon, -> { grouped_by_tag_id.having("COUNT(dish_tags.dish_id) < ?", 5) }
  scope :popular, -> { ordered_by_popularity_desc.take(5) }

  validate :name, :name_validator

  private

  def name_validator
    if name == nil || name.empty?
      errors.add(:name, "can't be presence")
    elsif name.size < 3
      errors.add(:name, "must be 3 or more characters")
    elsif name.scan(/\w+/).size > 2
      errors.add(:name, "can't be more than 2 words")
    end
  end

end
