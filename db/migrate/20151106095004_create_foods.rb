class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :price
      t.references :place, index: true, foreign_key: true
      t.references :photo, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
