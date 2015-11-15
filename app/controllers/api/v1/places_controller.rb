module Api
  module V1
    class PlacesController < ApiController

      api! 'Get places'
      description 'Return places'
      meta :object =>
      {
        :count => "int",
        :items => [
          {
            :id => "int",
            :name => "string",
            :address => "string",
            :location => {
              :lat => "float",
              :long => "float"
            }
          }
        ]
      }
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

      api! 'Add place'
      description 'Add place'
      meta :object =>
      {
        :id => "int",
        :name => "string",
        :address => "string",
        :location => {
          :lat => "float",
          :long => "float"
        }
      }
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
  end
end
