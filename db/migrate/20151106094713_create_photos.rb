class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :photo_1x

      t.timestamps null: false
    end
  end
end
