class PlacesController < ApiController
  skip_before_action :verify_authenticity_token

  def get
    param! :name, String, required: false
    param! :location, required: false
    param! :count, Integer, required: false, min: 0
    param! :offset, Integer, required: false, min: 0

    unless params[:name].nil?
      places = Place.search_by_name(params[:name])
    else
      places = Place.all
    end

    unless params[:location].nil?
    end

    pc = Collection.new
    pc.count = places.count

    unless params[:count].nil?
      places = places.limit(params[:count])
    end

    unless params[:offset].nil?
      places = places.offset(params[:offset]);
    end

    pc.items = places

    answer PlaceCollectionRepresenter.new(pc)
  end

  def post
    param! :name, String, required: true
    param! :location, Array, required: true
    param! :address, String, required: false

    place = Place.new
    place.name = params[:name]
    place.location = params[:location]

    unless params[:address].nil?
      place.address = params[:address];
    end

    place.save

    answer PlaceRepresenter.new(place)
  end
end
