require 'pry'
class Tag < ActiveRecord::Base
  has_many :dish_tags
  has_many :dishes, through: :dish_tags

  scope :with_name, -> (name) { where(name: name) }

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
