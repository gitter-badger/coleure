class AddChildrenCountToPalettes < ActiveRecord::Migration
  def change
    add_column :palettes, :children_count, :integer, index: true
  end
end
