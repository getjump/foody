class Food < ActiveRecord::Base
  has_many :photos
  belongs_to :place
end
