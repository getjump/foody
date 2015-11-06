class Food < ActiveRecord::Base
  include Elasticsearch::Model

  belongs_to :photo
  has_many :tags, through: :food_tags
  has_many :food_tags
  belongs_to :place
end
