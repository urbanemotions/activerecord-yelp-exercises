require_relative 'spec_helper'

describe 'Dish' do

  let(:alices_restaurant) {Restaurant.create(:name => "Alice's Restaurant")}

  let(:italian) {Tag.create(:name => "italian")}
  let(:vegetarian) {Tag.create(:name => "vegetarian")}

  let!(:pizza) {Dish.create(:name => "pizza", :tags => [italian], :restaurant => alices_restaurant)}
  let!(:pasta) {Dish.create(:name => "pasta", :tags => [italian, vegetarian], :restaurant => alices_restaurant)}
  let!(:soda)  {Dish.create(:name => "soda", :restaurant => alices_restaurant)}
  let!(:water) {Dish.create(:name => "water", :restaurant => alices_restaurant)}

  it "has a name" do 
    expect(pizza.name).to eq("pizza")
  end
  
  it "has associated tags in an array" do
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
  
  it "invokes the validations associated with DishTag" do 
    # Somehow we need to verify here that the valitations on DishTag are actually
    # checked whenever we add a tag to a dish.
  end

  describe 'Dish.names' do

    it 'returns an array of all dish names' do
      expect(Dish.names).to contain_exactly("pizza", "pasta", "soda", "water")
    end

  end

  describe 'Dish.max_tags' do

    it 'returns a signle dish with the most tags' do
      expect(Dish.max_tags).to eq(pasta)
    end

  end

  describe 'Dish.untagged' do

    it "returns an array of dishes with no tags" do
      expect(Dish.untagged).to contain_exactly(soda, water)
    end

  end 

  describe 'Dish.average_tag_count' do

    it "returns the average tag count for all dishes" do
      expect(Dish.average_tag_count).to eq(0.75)
    end

  end

end
