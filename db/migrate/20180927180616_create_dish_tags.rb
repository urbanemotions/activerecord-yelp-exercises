class CreateDishTags < ActiveRecord::Migration[4.2]
  def change
    create_table :dish_tags do |t|
      t.references :dish
      t.references :tag
    end
  end
end
