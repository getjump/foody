class Tag < ActiveRecord::Base
  include Elasticsearch::Model

  has_many :foods, through: :food_tags
  has_many :food_tags
end
