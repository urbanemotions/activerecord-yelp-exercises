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
end
