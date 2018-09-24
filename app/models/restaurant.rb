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
end
