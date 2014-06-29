class CreateColorpalettes < ActiveRecord::Migration
  def change
    create_table :colorpalettes do |t|
      t.string :name

      t.timestamps
    end
  end
end
