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
end
