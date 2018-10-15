require_relative 'spec_helper'

describe 'DishTag' do

  describe 'model' do
    it 'extends ActiveRecord::Base' do
      expect(DishTag).to be < ActiveRecord::Base
    end

    it 'belongs to a dish' do
      expect(DishTag.reflect_on_association(:dish).macro).to eq(:belongs_to)
    end

    it 'belongs to a tag' do
      expect(DishTag.reflect_on_association(:tag).macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    let!(:alices) {Restaurant.create(:name => "Alice's Restaurant")}
    let!(:veggie) {Tag.create(:name => "vegetarian")}
    let!(:salad)  {Dish.create(:name => "salad", :restaurant => alices)}

    it 'validates that dishes can only have on of any particular tag' do
      expect(DishTag.new(dish: salad, tag: veggie).valid?).to be true

      DishTag.create(dish: salad, tag: veggie)
      expect(DishTag.new(dish: salad, tag: veggie).valid?).to be false
    end
  end

end
