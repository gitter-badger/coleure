class AddPaletteReferencesToColor < ActiveRecord::Migration
  def change
    add_reference :colors, :palette, index: true
  end
end
