class FoodTag < ActiveRecord::Base
  belongs_to :food
  belongs_to :tag
end
