require_relative 'spec_helper'

describe 'Order' do
  describe 'model' do
    it 'extends ActiveRecord::Base' do
      expect(Order).to be < ActiveRecord::Base
    end
    it 'belongs to a Customer' do
      expect(Order.reflect_on_association(:customer).macro).to eq(:belongs_to)
    end
    it 'belongs to a Restaurant' do
      expect(Order.reflect_on_association(:restaurant).macro).to eq(:belongs_to)
    end
    it 'has many dishes' do
      expect(Order.reflect_on_association(:dishes).macro).to eq(:has_many)
    end
  end
  describe 'validations' do
    let(:r) {Restaurant.find_or_create_by(name: "Alice's Restaurant")}
    let(:c) {Customer.find_or_create_by(name: "Alice", lat: 0, lon: 0)}
    let(:d) {Dish.find_or_create_by(name: "pizza", restaurant: r)}

    it 'validates that customer is present' do
      expect(Order.new(customer: nil, restaurant: r, dishes: [d]).valid?).to be false
      expect(Order.new(customer: c, restaurant: r, dishes: [d]).valid?).to be true
    end
    it 'validates that restaurant is present' do
      expect(Order.new(customer: c, restaurant: nil, dishes: [d]).valid?).to be false
      expect(Order.new(customer: c, restaurant: r, dishes: [d]).valid?).to be true
    end
    it 'validates that it has at lease 1 dish' do
      expect(Order.new(customer: c, restaurant: r).valid?).to be false
      expect(Order.new(customer: c, restaurant: r, dishes: []).valid?).to be false
      expect(Order.new(customer: c, restaurant: r, dishes: [d]).valid?).to be true
    end
  end
end
