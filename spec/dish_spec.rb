require_relative 'spec_helper'

describe 'Dish' do

  describe 'model' do
    it 'extends ActiveRecord::Base' do
      expect(Dish).to be < ActiveRecord::Base
    end

    it 'has a name' do
      expect(Dish.column_names).to include("name")
    end

    it 'has many tags' do
      expect(Dish.reflect_on_association(:tags).macro).to eq(:has_many)
    end

    it 'belongs to a restuarant' do
      expect(Dish.reflect_on_association(:restaurant).macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    let(:alices) { Restaurant.find_or_create_by(name: "Alice's Restaurant") }

    it "must have a name" do
      expect(Dish.new(name: nil, restaurant: alices).valid?).to be false
      expect(Dish.new(name: "name", restaurant: alices).valid?).to be true
    end

    it 'must have a restaurant' do
      expect(Dish.new(:name => "Pizza", :restaurant => nil).valid?).to be false
      expect(Dish.new(:name => "Pizza", :restaurant => alices).valid?).to be true
    end

    it 'invokes validations for associated DishTags' do
      # Somehow we need to verify here that the valitations on DishTag are actually
      # checked whenever we add a tag to a dish.
    end
  end

  describe 'queries' do
    before(:all) do
      @alices = Restaurant.find_or_create_by(name: "Alice's Restaurant")
      @dish_hash = {
        burger: ["meat", "fat", "meal"],
        fry: ["vegetarian", "side", "potato", "salty"],
        soda: ["sugar", "vegetarian"],
        taco: ["vegetarian"],
        water: [],
        ice: []
      }

      @dish_hash.each do |dish, tags|
        d = Dish.create(name: dish, restaurant: @alices)
        tags.each do |tag|
          d.tags << Tag.find_or_create_by(name: tag)
        end
      end
    end

    describe 'Dish.names' do
      it 'returns an array of all dish names' do
        expect(Dish.names).to match_array @dish_hash.keys.map(&:to_s)
      end
    end

    describe 'Dish.max_tags' do
      it 'returns a signle dish with the most tags' do
        max_tags = @dish_hash.max_by { |entry| entry[1].length }
        expected = Dish.find_by(name: max_tags[0].to_s)
        expect(Dish.max_tags).to eq(expected)
      end
    end

    describe 'Dish.untagged' do
      it 'returns an array of dishes with no tags' do
        expected = @dish_hash.select { |key, value| value.length == 0 }
                             .map { |key, value| Dish.find_by(name: key.to_s) }
        expect(Dish.untagged).to match_array(expected)
      end
    end

    describe 'Dish.average_tag_count' do
      it 'returns the average tag count for all dishes' do
        total_tags = @dish_hash.reduce(0) do |sum, (dish, tags)|
          sum += tags.length
        end
        expected = total_tags.to_f / @dish_hash.keys.count.to_f
        expect(Dish.average_tag_count).to be_within(1e-12).of(expected)
      end
    end

    describe 'Dish#tag_count' do
      it 'returns the number of tags associated with this dish' do
        @dish_hash.each do |dish, tags|
          d = Dish.find_by(name: dish)
          expect(d.tag_count).to eq(tags.length)
        end
      end
    end
 
    describe 'Dish#tag_names' do
      it 'returns an array of the names of each tag associated with this dish' do
        @dish_hash.each do |dish, tags|
          d = Dish.find_by(name: dish)
          expect(d.tag_names).to match_array(tags)
        end
      end
    end
  end

end
