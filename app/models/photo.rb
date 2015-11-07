require 'carrierwave/orm/activerecord'

class Photo < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader

  belongs_to :place

  has_one :food
end
