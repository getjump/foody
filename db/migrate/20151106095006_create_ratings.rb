class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :food, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :type

      t.timestamps null: false
    end
  end
end
