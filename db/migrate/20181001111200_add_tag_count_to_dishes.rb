class AddTagCountToDishes < ActiveRecord::Migration[4.2]
  def change
    add_column :dishes, :tag_count, :integer, :default => 0, :null => false
  end
end
