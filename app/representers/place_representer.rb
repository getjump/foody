require 'roar/decorator'
require 'roar/json'

class PlaceRepresenter < Roar::Decorator
  include Roar::JSON

  property :name
  property :address
  property :location, extend: PointRepresenter
end
