class PlacesController < ApiController
  skip_before_action :verify_authenticity_token

  resource_description do
    formats [:json]
  end

  api :GET, '/places', 'Get places'
  description 'Return places'
  param :name, String, desc: 'String to search for in database'
  param :location, Array, desc: 'Array of location'
  param :count, :number, desc: 'Count of elements to get', min: 0, max: 100
  param :offset, :number, descs: 'Offset to get elements from', min: 0
  def get
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

  api :POST, '/places', 'Add place'
  description 'Add place'
  param :name, String, desc: 'Name of a place', required: true
  param :location, Array, desc: 'Array of location', required: true
  param :address, String, desc: "String address representation"
  def post
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
