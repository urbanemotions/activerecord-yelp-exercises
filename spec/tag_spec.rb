require_relative 'spec_helper'

describe 'Tag' do 

  let(:alices) {Restaurant.create(:name => "Alice's Restaurant")}

  it "has a name" do 
    tag = Tag.create(:name => "italian")
    expect(tag.name).to eq ("italian")
  end
    
  it "has associated dishes in an array" do 
    pizza   = Dish.create(:name => "pizza", :restaurant => alices)
    italian = Tag.create(:name => "italian", :dishes => [pizza])
    
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

  describe "Tag.most_common" do

    it "returns the tag with the most associated dishes" do
      three = Tag.create(:name => "three")
      two   = Tag.create(:name => "two")
      one   = Tag.create(:name => "one")

      for i in 1..3 do
        Dish.create(:name => "dish#{i}", :tags => [three], :restaurant => alices)
      end

      for i in 1..2 do
        Dish.create(:name => "dish#{i+3}", :tags => [two], :restaurant => alices)
      end

      Dish.create(:name => "dish6", :tags => [one], :restaurant => alices)
      expect(Tag.most_common).to eq(three)
    end

  end
  
end
