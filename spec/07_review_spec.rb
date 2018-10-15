require_relative 'spec_helper'

describe 'Review' do
  describe 'model' do
    it 'extends ActiveRecord::Base' do
      expect(Review).to be < ActiveRecord::Base
    end
    it 'has content' do
      expect(Review.column_names).to include('content')
    end
    it 'has a rating' do
      expect(Review.column_names).to include('rating')
    end
    it 'has a date' do
      expect(Review.column_names).to include('date')
    end
    it 'belongs to a Customer' do
      expect(Review.reflect_on_association(:customer).macro).to eq(:belongs_to)
    end
    it 'belongs to a Restaurant' do
      expect(Review.reflect_on_association(:restaurant).macro).to eq(:belongs_to)
    end
  end
end
