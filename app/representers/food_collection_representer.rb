require 'roar/decorator'
require 'roar/json'

class FoodCollectionRepresenter < Roar::Decorator
  include Representable::JSON

  property :count
  collection :items, extend: FoodRepresenter
end
