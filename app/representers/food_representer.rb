require 'roar/decorator'
require 'roar/json'

class FoodRepresenter < Roar::Decorator
  include Roar::JSON

  property :name
  property :price
  property :place, extend: PlaceRepresenter
  property :photo, extend: PhotoRepresenter, class: Photo
end
