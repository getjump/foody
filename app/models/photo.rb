class Photo < ActiveRecord::Base
  has_attached_file :photo, styles: { small: "64x64", med: "320x320", large: "400x400" }
  belongs_to :place

  has_one :food
end
