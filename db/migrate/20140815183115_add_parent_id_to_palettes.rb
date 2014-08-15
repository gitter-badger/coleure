class AddParentIdToPalettes < ActiveRecord::Migration
  def change
    add_column :palettes, :parent_id, :integer, index: true
  end
end
