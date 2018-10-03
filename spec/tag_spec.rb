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

  describe "Tag.least_common" do

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
      expect(Tag.least_common).to eq(one)
    end


  end

  describe "Tag.unused" do

    it "returns an array of all tags without associated dishes" do
      unused1 = Tag.create(:name => "lonely")
      unused2 = Tag.create(:name => "unloved")
      used    = Tag.create(:name => "best")

      Dish.create(:name => "some dish", :restaurant => alices, :tags => [used])

      expect(Tag.unused).to contain_exactly(unused1, unused2)
    end

  end

  describe "Tag.uncommon" do

    it "returns an array of all tags associated with fewer than 5 dishes" do
      fewerer_than_5 = Tag.create(:name => "fewererthan 5")
      fewer_than_5   = Tag.create(:name => "fewerthan 5")
      exactly_5      = Tag.create(:name => "eactly 5")
      more_than_5    = Tag.create(:name => "morethan 5")

      Dish.create(:name => "1", :restaurant => alices, :tags => [fewerer_than_5])

      for i in 2..5
        Dish.create(:name => "#{i}", :restaurant => alices, :tags => [fewer_than_5])
      end

      for i in 6..10
        Dish.create(:name => "#{i}", :restaurant => alices, :tags => [exactly_5])
      end

      for i in 11..30
        Dish.create(:name => "#{i}", :restaurant => alices, :tags => [more_than_5])
      end

      expect(Tag.uncommon).to contain_exactly(fewerer_than_5, fewer_than_5)
    end

  end

  describe "Tag.popular" do

    it "returns the 5 most used tags" do
      for i in 1..10 do
        tag = Tag.create(:name => "tag#{i}")
        for j in 1..i do
          Dish.create(:name => "tag#{i}_dish#{j}", :restaurant => alices, :tags => [tag])
        end
      end

      binding.pry
      expect(Tag.popular).to match_array Tag.find(6,7,8,9,10)
    end

  end

end
