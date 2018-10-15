class Customer < ActiveRecord::Base
  has_many :orders
  has_many :reviews

  validates :name, presence: true
end
