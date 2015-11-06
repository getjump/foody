class Food < ActiveRecord::Base
  belongs_to :photo
  belongs_to :place
end
