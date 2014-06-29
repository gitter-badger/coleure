class CreateColoritems < ActiveRecord::Migration
  def change
    create_table :coloritems do |t|
      t.string :name
      t.string :hex
      t.boolean :mixed
      t.integer :order
      t.references :colorpalette, index: true

      t.timestamps
    end
  end
end
