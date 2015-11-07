class PlacesController < ApiController
  skip_before_action :verify_authenticity_token

  def get
    param! :name, String
    param! :location

    places = Place.all

    unless params[:name].nil?
      places = Place.search(query: { match: { name: params[:name] } }).records
    end

    unless params[:location].nil?
    end
  end

  def post
    param! :name, String, required: true
    param! :location, Array, required: true

    place = Place.new
    place.name = params[:name]
    place.location = params[:location]
    place.save

    answer PlaceRepresenter.new(place)
  end
end
