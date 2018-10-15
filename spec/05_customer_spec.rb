require_relative 'spec_helper'

describe 'Customer' do
  describe 'model' do
    it 'extends ActiveRecord::Base' do
      expect(Customer).to be < ActiveRecord::Base
    end
    it 'has a name' do
      expect(Customer.column_names).to include("name")
    end
    it 'has a lat(itude)' do
      expect(Customer.column_names).to include("lat")
    end
    it 'has a lon(gitude)' do
      expect(Customer.column_names).to include("lon")
    end
  end
end
