require 'carrierwave/orm/activerecord'

class Photo < ActiveRecord::Base
  belongs_to :place

  has_one :food
end
