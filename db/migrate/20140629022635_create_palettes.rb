class CreatePalettes < ActiveRecord::Migration
  def change
    create_table :palettes do |t|
      t.string :name

      t.timestamps
    end
  end
end
