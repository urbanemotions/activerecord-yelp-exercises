require_relative 'spec_helper'

describe 'DishOrder' do
  describe 'model' do
    it 'extends ActiveRecord::Base' do
      expect(DishOrder).to be < ActiveRecord::Base
    end
    it 'belongs to a Dish' do
      expect(DishOrder.reflect_on_association(:dish).macro).to eq(:belongs_to)
    end
    it 'belongs to an Order' do
      expect(DishOrder.reflect_on_association(:order).macro).to eq(:belongs_to)
    end
  end
  describe 'validations' do
    let(:r1) {Restaurant.find_or_create_by(name: "R1")}
    let(:r2) {Restaurant.find_or_create_by(name: "R2")}

    let(:d1r1) {Dish.find_or_create_by(name: "D1R1", restaurant: r1)}
    let(:d2r1) {Dish.find_or_create_by(name: "D2R1", restaurant: r1)}

    let(:d1r2) {Dish.find_or_create_by(name: "D1R2", restaurant: r2)}

    let(:c) {Customer.find_or_create_by(name: 'c', lat: 0, lon: 0)}
    let(:o) {Order.create(customer: c, restaurant: r1, dishes: [d1r1])}

    it 'validates that the dish and order are from the same restaurant' do
      expect(DishOrder.new(dish: d1r2, order: o).valid?).to be false      
      expect(DishOrder.new(dish: d2r1, order: o).valid?).to be true
    end
  end
end
