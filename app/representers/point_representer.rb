require 'roar/decorator'
require 'roar/json'

class PointRepresenter < Roar::Decorator
  include Roar::JSON

  property :first, as: "lat"
  property :last, as: "long"
end
