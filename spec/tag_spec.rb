require_relative 'spec_helper'

describe 'Tag' do 

  let(:alices_restaurant) {Restaurant.create(:name => "Alice's Restaurant")}
  
  it "has a name" do 
    tag = Tag.create(:name => "italian")
    expect(tag.name).to eq ("italian")
  end
    
  it "has associated dishes in an array" do 
    italian = Tag.create(:name => "italian")
    
    pizza = Dish.new(:name => "pizza", :restaurant => alices_restaurant)
    pizza.tags << italian 
    pizza.save 
    
    pizza.reload
    expect(italian.dishes).to include(pizza)
    expect(pizza.tags).to include(italian)
  end
  
  it "validates that name is present" do 
    expect(Tag.new(:name => nil).valid?).to be false
    expect(Tag.new(:name => "italian").valid?).to be true 
  end
  
  it "validates that name is 3 or more characters long" do 
    expect(Tag.new(:name => "").valid?).to be false
    expect(Tag.new(:name => "a").valid?).to be false
    expect(Tag.new(:name => "ab").valid?).to be false
    expect(Tag.new(:name => "abc").valid?).to be true
    expect(Tag.new(:name => "abcd").valid?).to be true
  end
  
  it "validates that name is no more than 2 words long" do 
    expect(Tag.new(:name => "one two three").valid?).to be false 
    expect(Tag.new(:name => "one two").valid?).to be true 
    expect(Tag.new(:name => "one").valid?).to be true
  end
  
end