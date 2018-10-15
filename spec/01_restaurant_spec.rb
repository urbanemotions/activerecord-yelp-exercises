require_relative 'spec_helper'

describe 'Resaurant' do

  describe 'model' do
    it 'extends ActiveRecord::Base' do
      expect(Restaurant).to be < ActiveRecord::Base
    end

    it 'has a name' do
      expect(Restaurant.column_names).to include("name")
    end

    it 'has many dishes' do
      expect(Restaurant.reflect_on_association(:dishes).macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    it 'validates that name is present' do
      expect(Restaurant.new(:name => nil).valid?).to be false
      expect(Restaurant.new(:name => "Some Name").valid?).to be true
    end
  end

  describe 'queries' do
    before(:all) do
      @restaurants_hash = {
        :McDonalds => {
          burger: ["meat", "meal"],
          fries: ["vegetarian", "side"],
          shake: ["drink", "side"]
        },
        :Chipotle => {
          taco: ["spicy", "vegetarian"],
          burrito: ["spicy", "meal"]
        },
        :JimmyJohns => {
          sandwich: ["meal", "meat"],
          chips: ["side", "vegetarian"],
          soda: ["vegetarian", "drink"]
        },
        :Chopt => {
          salad00: ["vegetarian"],
          salad01: ["vegetarian"],
          salad02: ["vegetarian"],
          salad03: ["vegetarian"],
          salad04: ["vegetarian"],
          salad05: ["vegetarian"],
          salad06: ["vegetarian"],
          salad07: ["vegetarian"],
          salad08: ["vegetarian"],
          salad09: ["vegetarian"],
          salad10: ["vegetarian"],
          salad11: ["vegetarian"],
          salad12: ["vegetarian"],
          salad13: ["vegetarian"],
          salad14: ["vegetarian"],
          salad15: ["vegetarian"],
          salad16: ["vegetarian"],
          salad17: ["vegetarian"],
          salad18: ["vegetarian"],
          salad19: ["vegetarian"],
          salad20: ["vegetarian"]
        },
        :SubwaySandwiches => {
          sandwich: ["meal", "meat"],
          chips: ["side", "vegetarian"],
          soda: ["vegetarian", "drink"]
        },
        :BopPizza => {
          pizza: ["meal"]
        },
        :PandaExpress => {
          panda: ["meat", "meal"],
          express: ["meal", "mistery"]
        },
        :FiveGuysBurgerAndFries => {
          burger: ["meat", "meal"],
          fries: ["vegetarian", "side"],
          soda: ["vegetarian", "drink"]
        },
        :RiceBar => {
          rice: ["vegetarian", "meal"],
          noddles: ["meal"]
        },
        :DistrictTaco => {
          taco: ["meal"]
        }
      }

      @restaurants_hash.each do |name, dish_hash|
        r = Restaurant.create(name: name)
        dish_hash.each do |dish, tags|
          d = Dish.create(name: dish, restaurant: r)
          tags.each do |tag|
            t = Tag.find_or_create_by(name: tag)
            d.tags << t
          end
        end
      end
    end

    describe 'Restaurant.mcdonalds' do
      let(:mcdonalds) {Restaurant.find_by(:name => "McDonalds")}
      it 'finds the restaurant with the name "McDonalds"' do
        expect(Restaurant.mcdonalds).to eq(mcdonalds)
      end
    end

    describe 'Restaurant.tenth' do
      let(:tenth) {Restaurant.find(10)}
      it 'finds the tenth restaurant' do
        expect(Restaurant.tenth).to eq(tenth)
      end
    end

    describe 'Restaurant.with_long_names' do
      it 'finds all the restaurants with names longer than 12 characters' do
        expected = @restaurants_hash.select { |name, dish_hash| name.length > 12 }
                                    .map { |name, dish_hash| Restaurant.find_by(name: name) }
        expect(Restaurant.with_long_names).to match_array(expected)
      end
    end

    describe 'Restaurant.focused' do
      it 'finds all the restaurants with fewer than 5 dishes' do
        expected = @restaurants_hash.select { |name, dish_hash| dish_hash.keys.length < 5 }
                                    .map    { |name, dish_hash| Restaurant.find_by(name: name) }
        expect(Restaurant.focused).to match_array(expected)
      end
    end

    describe 'Restaurant.large_menu' do
      it 'finds all the restaurants with more than 20 dishes' do
        expected = @restaurants_hash.select { |name, dish_hash| dish_hash.keys.length > 20 }
                                    .map    { |name, dish_hash| Restaurant.find_by(name: name) }
        expect(Restaurant.large_menu).to match_array(expected)
      end
    end

    describe 'Restaurant.vegetarian' do
      it 'finds all the restaurants where all of the dishes are tagged vegetarian' do
        expected = @restaurants_hash.select { |name, dish_hash| dish_hash.select { |dish, tags| !tags.include?("vegetarian") }.length == 0 }
                                    .map    { |name, dish_hash| Restaurant.find_by(name: name) }
        expect(Restaurant.vegetarian).to match_array(expected)
      end
    end

    describe 'Restaurant.name_like' do
      it 'finds all restaurants with names that contain the passed in string' do
        expected = @restaurants_hash.select { |name, dish_hash| name.to_s.downcase.include?("ch") }
                                    .map    { |name, dish_hash| Restaurant.find_by(name: name) }
        expect(Restaurant.name_like("ch")).to match_array(expected)
      end
    end

    describe 'Restaurant.name_not_like' do
      it 'finds all restaurants with names that do not contain the passed in string' do
        expected = @restaurants_hash.select { |name, dish_hash| !name.to_s.downcase.include?("ch") }
                                    .map    { |name, dish_hash| Restaurant.find_by(name: name) }
        expect(Restaurant.name_not_like("ch")).to match_array(expected)
      end
    end

    describe 'Restaurant#most_popular_tag' do
      it 'returns the most commonly used tag at this restaurant' do
        @restaurants_hash.each do |name, dish_hash|
          r = Restaurant.find_by(name: name)
          freq = Hash.new(0)
          dish_hash.each { |dish, tags| tags.each { |tag| freq[tag] += 1 } }
          expected = Tag.find_by(name: freq.max_by { |key, value| value }[0])
          expect(r.most_popular_tag).to eq(expected)
        end
      end
    end

  end
    
end
