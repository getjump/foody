require 'roar/decorator'
require 'roar/json'

class LikesRepresenter < Roar::Decorator
  include Roar::JSON

  property :status
end
