require_relative 'spec_helper'

describe 'Tag' do 

  describe 'model' do
    it 'extends ActiveRecord::base' do
      expect(Tag).to be < ActiveRecord::Base
    end
 
    it 'has a name' do
      expect(Tag.column_names).to include("name")
    end

    it 'has many dishes' do
      expect(Tag.reflect_on_association(:dishes).macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    it 'validates that name is present' do
      expect(Tag.new(name: nil).valid?).to be false
      expect(Tag.new(name: "vegetarian").valid?).to be true
    end

    it 'validates that name is 3 or more characters long' do
      expect(Tag.new(:name => "").valid?).to be false
      expect(Tag.new(:name => "a").valid?).to be false
      expect(Tag.new(:name => "ab").valid?).to be false
      expect(Tag.new(:name => "abc").valid?).to be true
      expect(Tag.new(:name => "abcd").valid?).to be true
    end

    it 'validates that name is one or two words, not more' do
      expect(Tag.new(:name => "one two three").valid?).to be false 
      expect(Tag.new(:name => "one two").valid?).to be true 
      expect(Tag.new(:name => "one").valid?).to be true
    end
  end

  describe 'queries' do
    before(:all) do
      @restaurants_hash = {
        :McDonalds => {
          burger: ["meat", "meal"],
          fries: ["side", "meat"],
          shake: ["drink", "side", "meat"]
        },
        :Chipotle => {
          taco: ["meal", "spicy", "vegetarian"],
          burrito: ["spicy", "meal"],
          bowel: ["spicy", "meal"]
        },
        :JimmyJohns => {
          sandwich: ["meal", "meat"],
          sandwich2: ["meat", "meal"],
          sandwich3: ["meat", "meal"],
          sandwich4: ["meat", "meal"],
          chips: ["side", "vegetarian"],
          soda: ["vegetarian", "drink"]
        }
      }

      @tag_freq = Hash.new(0)
      @tag_restaurants = Hash.new
      @restaurants_hash.each do |name, dish_hash|
        r = Restaurant.create(name: name)
        dish_hash.each do |dish, tags|
          d = Dish.create(name: dish, restaurant: r)
          tags.each do |tag|
            t = Tag.find_or_create_by(name: tag)
            d.tags << t
            @tag_freq[tag] += 1

            if @tag_restaurants[tag] == nil
              @tag_restaurants[tag] = []
            end
            @tag_restaurants[tag] << name
          end
        end
      end

      @unused1 = Tag.create(name: "unused1")
      @unused2 = Tag.create(name: "unused2")
    end

    describe "Tag.most_common" do
      it "returns the tag with the most associated dishes" do
        expected = Tag.find_by(name: @tag_freq.max_by {|tag, freq| freq}[0])
        expect(Tag.most_common).to eq(expected)
      end
    end

    describe "Tag.least_common" do
      it "returns the tag with the fewest associated dishes" do
        expected = Tag.find_by(name: @tag_freq.min_by {|tag, freq| freq}[0])
        expect(Tag.least_common).to eq(expected)
      end
    end

    describe "Tag.unused" do
      it "returns an array of all tags without associated dishes" do
        expect(Tag.unused).to contain_exactly(@unused1, @unused2)
      end
    end

    describe "Tag.uncommon" do
      it "returns an array of all tags associated with fewer than 5 dishes" do
        expected = @tag_freq.select {|tag, freq| freq < 5}
                            .map    {|tag, freq| Tag.find_by(name: tag)}
        expect(Tag.uncommon).to match_array(expected)
      end
    end

    describe "Tag.popular" do
      it "returns the 5 most used tags" do
        expected = @tag_freq.sort_by {|tag, freq| -freq}
                            .map     {|keyvalue| Tag.find_by(name: keyvalue[0])}
                            .slice(0, 5)
        expect(Tag.popular).to match_array(expected)
      end
    end

    describe "Tag#restaurants" do
      it "returns and array of all restaurants with dishes using this tag" do
        @tag_restaurants.each do |tag, restaurants|
          expected = restaurants.uniq.map {|name| Restaurant.find_by(name: name)}
          expect(Tag.find_by(name: tag).restaurants).to match_array(expected)
        end
      end
    end

    describe "Tag#top_restaurant" do
      it "returns the restaurant with the most dishes associated with this tag" do
        @tag_restaurants.each do |tag, restaurants|
          restaurant_freq = Hash.new(0)
          restaurants.each {|name| restaurant_freq[name] += 1}
          expected = Restaurant.find_by(name: restaurant_freq.max_by {|name, freq| freq}[0])
          expect(Tag.find_by(name: tag).top_restaurant).to eq(expected)
        end
      end
    end

    describe "Tag#dish_count" do
      it "returns the number of dishes associated with this tag" do
        @tag_freq.each do |tag, expected|
          expect(Tag.find_by(name: tag).dish_count).to eq(expected)
        end
      end

      it "returns 0 when no dishes are associated with this tag" do
        expect(@unused1.dish_count).to eq(0)
      end
    end
  end

end
