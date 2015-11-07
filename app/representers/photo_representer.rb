require 'roar/decorator'
require 'roar/json'

class PhotoRepresenter < Roar::Decorator
  include Roar::JSON

  property :photo
end
