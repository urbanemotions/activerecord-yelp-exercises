class CreateDishTags < ActiveRecord::Migration
  def change
    create_table :dish_tags do |t|
      t.references :dish
      t.references :tag
    end
  end
end
