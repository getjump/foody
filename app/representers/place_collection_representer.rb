require 'roar/decorator'
require 'roar/json'

class PlaceCollectionRepresenter < Roar::Decorator
  include Representable::JSON::Collection

  items extend: PlaceRepresenter
end
