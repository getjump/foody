class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :photo_1x
      t.references :food, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
