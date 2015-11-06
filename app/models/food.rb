class Food < ActiveRecord::Base
  has_many :photos
  has_many :tags, through: :food_tags
  has_many :food_tags
  belongs_to :place
end
