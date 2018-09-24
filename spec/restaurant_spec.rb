require_relative 'spec_helper'

describe 'Resaurant' do

  it "has a name" do
    restaurant = Restaurant.create(:name => "Alice's Restaurant")
    expect(restaurant.name).to eq ("Alice's Restaurant")
  end
  
  it "has associated dishes in an array" do
    alices = Restaurant.create(:name => "Alice's Restaurant")
    
    pizza = Dish.new(:name => "pizza")
    pizza.restaurant = alices
    pizza.save
    
    pizza.reload
    expect(alices.dishes).to include(pizza)
    expect(pizza.restaurant).to eq(alices)
  end
  
  it "validates that name is present" do 
    expect(Restaurant.new(:name => nil).valid?).to be false
    expect(Restaurant.new(:name => "Alice's Restaurant").valid?).to be true
  end

  describe 'Restaurant.mcdonalds' do

    it 'finds the restaurant with the name "McDonalds"' do
      mcdonalds = Restaurant.create(name: "McDonalds")
      expect(Restaurant.mcdonalds.id).to eq(mcdonalds.id)
    end

  end

  describe 'Restaurant.tenth' do

    it 'finds the tenth restaurant' do
      for i in 1..10
        Restaurant.create(:name => "restaurant_#{i}")
      end

      expect(Restaurant.tenth.id).to eq(10)
    end
  end
    
end
