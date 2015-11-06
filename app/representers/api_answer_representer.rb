require 'representable/json'

module ApiAnswerRepresenter
  include Representable::JSON

  property :object
  property :error
end
