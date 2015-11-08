require 'roar/decorator'
require 'roar/json'

class FoodRepresenter < Roar::Decorator
  include Roar::JSON

  property :name
  property :price
  property :place, extend: PlaceRepresenter
  property :ratings_count, as: "ratings"
  property :likes
  property :tags, extend: TagsRepresenter
  property :photo, extend: PhotoRepresenter, class: Photo
end
