require 'roar/decorator'
require 'roar/json'

class TagsRepresenter < Roar::Decorator
  include Representable::JSON::Collection

  items extend: TagRepresenter
end
