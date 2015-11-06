class CreateFoodTags < ActiveRecord::Migration
  def change
    create_table :food_tags do |t|
      t.references :food, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
