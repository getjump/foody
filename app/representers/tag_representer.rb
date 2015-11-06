require 'roar/decorator'
require 'roar/json'

class TagRepresenter < Roar::Decorator
  include Roar::JSON

  property :name
end
