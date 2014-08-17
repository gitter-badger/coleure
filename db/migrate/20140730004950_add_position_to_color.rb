class AddPositionToColor < ActiveRecord::Migration
  def change
    add_column :colors, :position, :integer
  end
end
