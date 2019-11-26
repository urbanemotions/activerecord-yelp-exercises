class CreateReviews < ActiveRecord::Migration[4.2]
  def change
    create_table :reviews do |t|
      t.string :content
      t.integer :rating
      t.date :date
      t.integer :customer_id
      t.integer :restaurant_id
    end
  end
end
