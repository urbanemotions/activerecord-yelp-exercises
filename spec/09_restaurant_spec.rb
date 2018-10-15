require_relative 'spec_helper'

describe 'Restaurant' do
  describe 'model' do
    it 'has a lat(itude)' do
      expect(Restaurant.column_names).to include("lat")
    end
    it 'has a lon(gitude)' do
      expect(Restaurant.column_names).to include("lon")
    end
  end
end
