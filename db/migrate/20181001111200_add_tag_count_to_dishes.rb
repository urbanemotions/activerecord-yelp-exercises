class AddTagCountToDishes < ActiveRecord::Migration
  def change
    add_column :dishes, :tag_count, :integer, :default => 0, :null => false
  end
end
