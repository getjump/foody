require 'roar/decorator'
require 'roar/json'

class FoodCollectionRepresenter < Roar::Decorator
  include Representable::JSON::Collection

  items extend: FoodRepresenter
end
