class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.string :name
      t.string :hex
      t.boolean :mixed

      t.timestamps
    end
  end
end
