require 'roar/decorator'
require 'roar/json'

class PhotoRepresenter < Roar::Decorator
  include Roar::JSON

  property :id
  property :fetch, as: "photo"
end
