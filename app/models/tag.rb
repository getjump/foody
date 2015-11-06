class Tag < ActiveRecord::Base
  has_many :foods, through: :food_tags
  has_many :food_tags
end
