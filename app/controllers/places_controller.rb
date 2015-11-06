class PlacesController < ApiController
  def get
    param! :name, String
    param! :location
  end

  def post
    param! :name, String, required: true
    param! :location, required: true
  end
end
