require_relative 'spec_helper'

describe 'Dish' do

  let(:alices_restaurant) {Restaurant.create(:name => "Alice's Restaurant")}

  it "has a name" do 
    dish = Dish.create(:name => "pizza", :restaurant => alices_restaurant)
    expect(dish.name).to eq("pizza")
  end
  
  it "has associated tags in an array" do
    pizza = Dish.create(:name => "pizza", :restaurant => alices_restaurant)
    
    italian = Tag.create(:name => "italian")
    pizza.tags << italian
    
    italian.reload
    expect(pizza.tags).to include(italian)
    expect(italian.dishes).to include(pizza)
  end
  
  it "validates that name is present" do 
    expect(Dish.new(:name => nil, :restaurant => alices_restaurant).valid?).to be false
    expect(Dish.new(:name => "Pizza", :restaurant => alices_restaurant).valid?).to be true
  end
  
  it "validates that restaurant is present" do 
    expect(Dish.new(:name => "Pizza", :restaurant => nil).valid?).to be false
    expect(Dish.new(:name => "Pizza", :restaurant => alices_restaurant).valid?).to be true
  end
  
  it "validates that each tag is unique" do 
    pizza = Dish.create(:name => "pizza", :restaurant => alices_restaurant)
    
    italian = Tag.create(:name => "italian")
    pizza.tags << italian
    expect(pizza.valid?).to be true
    pizza.tags << italian
    expect(pizza.valid?).to be false
  end

end
