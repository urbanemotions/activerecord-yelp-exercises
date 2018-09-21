require_relative 'spec_helper'

describe 'DishTag' do

  let(:alices_restaurant) {Restaurant.create(:name => "Alice's Restaurant")}

  it "validates that dishes can only have one of any particular tag" do 
    pizza = Dish.create(:name => "pizza", :restaurant => alices_restaurant)
    italian = Tag.create(:name => "italian")

    dish_tag_1 = DishTag.create(dish: pizza, tag: italian)
    expect(dish_tag_1.valid?).to be true

    dish_tag_2 = DishTag.create(dish: pizza, tag: italian)
    expect(dish_tag_2.valid?).to be false
  end

end
