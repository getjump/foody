require 'roar/decorator'
require 'roar/json'

class PlaceCollectionRepresenter < Roar::Decorator
  include Representable::JSON

  property :count
  collection :items, extend: PlaceRepresenter
end
