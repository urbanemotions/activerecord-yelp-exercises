describe 'Dish' do
  describe 'model' do
    it 'has a price' do
      expect(Dish.column_names).to include('price')
    end
    it 'has a cost' do
      expect(Dish.column_names).to include('cost')
    end
  end
end
