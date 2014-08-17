class AddRgbAndHslToColor < ActiveRecord::Migration
  def change
    add_column :colors, :rgb, :string
    add_column :colors, :hsl, :string
  end
end
