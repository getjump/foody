require 'roar/decorator'
require 'roar/json'

class PlaceRepresenter < Roar::Decorator
  include Roar::JSON

  property :name
  property :location, extend: PointRepresenter
end
