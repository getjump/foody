class PlacesController < ApiController
  skip_before_action :verify_authenticity_token

  def get
    param! :name, String, required: false
    param! :location, required: false

    unless params[:name].nil?
      places = Place.search_by_name(params[:name])
    else
      places = Place.all
    end

    unless params[:location].nil?
    end

    answer PlaceCollectionRepresenter.new(places)
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
