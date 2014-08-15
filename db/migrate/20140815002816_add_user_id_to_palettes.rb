class AddUserIdToPalettes < ActiveRecord::Migration
  def change
    add_column :palettes, :user_id, :integer, index: true
  end
end
