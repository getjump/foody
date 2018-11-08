require 'multi_json'

module Api
  module V1
    class FoodController < ApiController

      api! 'Get food'
      description 'Return basic feed'
      meta :object =>
      {
        :count => "int",
        :items => [
          {
            :id => "int",
            :name => "string",
            :price => "int",
            :place => {
              :id => "int",
              :name => "string",
              :address => "string",
              :location => {
                :lat => "float",
                :long => "float"
              }
            },
            :ratings => {
              :tried => "int",
              :liked => "int"
            },
            :likes? => {
              :status => "int"
            },
            :tags => [
              "string"
            ],
            :photo => {
              :id => "int",
              :urls => {
                :original => "string",
                :medium => "string",
                :thumb => "string",
                :square => "string"
              }
            }
          }
        ]
      }
      param :search, String, desc: 'String to search for in database'
      param :tags, Array, desc: 'Array of tags ids to lookup for items with that tags'
      param :price, Hash, desc: 'Price array' do
        param :min, :number, desc: 'Minimal price'
        param :max, :number, desc: 'Maximal price'
      end
      param :device, String, desc: 'Device hash, to look for user likes'
      param :count, :number, desc: 'Count of elements to get', min: 0, max: 100
      param :offset, :number, descs: 'Offset to get elements from', min: 0

      def get
        unless params[:search].nil?
          food = Food.search_by_name(params[:search]).group("#{PgSearch::Configuration.alias('foods')}.rank").top
          count = food.group("foods.id")
        else
          food = Food.top
          count = Food.all
        end

        unless params[:count].nil?
          food = food.limit(params[:count])
        end

        unless params[:offset].nil?
          food = food.offset(params[:offset]);
        end

        unless params[:tags].nil?
          food = food.joins(:tags).where("tags.id" => params[:tags])
          count = count.joins(:tags).where("tags.id" => params[:tags])
        #   params[:tags].each do |tag_id|
        #     count = count.where("tags.id" => tag_id)
        #     food = food.where("tags.id" => tag_id)
        #   end
        end

        unless params[:price].nil?
          price = params[:price]
          count = count.where(:price => price[:min]..price[:max])
          food = food.where(:price => price[:min]..price[:max])
        end

        unless params[:device].nil?
          user = User.where(:device_hash => params[:device]).take
          food.each do |f|
            f.user = user
          end
        end

        fc = Collection.new

        fc.items = food.includes(:place).includes(:tags).includes(:photo).includes(:ratings)

        fc.count = count.count

        obj = FoodCollectionRepresenter.new(fc)

        answer obj
      end

      api! 'Create food'
      description 'Create food'
      meta :object =>
      {
        :id => "int",
        :name => "string",
        :price => "int",
        :place => {
          :id => "int",
          :name => "string",
          :address => "string",
          :location => {
            :lat => "float",
            :long => "float"
          }
        },
        :ratings => {
          :tried => "int",
          :liked => "int"
        },
        :tags => [
          "string"
        ],
        :photo => {
          :id => "int",
          :urls => {
            :original => "string",
            :medium => "string",
            :thumb => "string",
            :square => "string"
          }
        }
      }
      param :name, String, desc: 'Name that should be assigned to food', required: true
      param :photo, :number, desc: 'Id of photo that should be assigned to food', required: true
      param :place, :number, desc: 'Id of place that should be assigned to food', required: true
      param :price, :number, desc: 'Price of food', required: true
      param :tags, Array, desc: 'Array of tags ids to add for food' do
        param "", :number, desc: 'Tag id'
      end

      def post
        food = Food.new
        food.name = params[:name]
        food.price = params[:price]
        food.photo_id = params[:photo]
        food.place_id = params[:place]

        unless params[:tags].nil?
          params[:tags].each do |tag_id|
            food.tags << Tag.find(tag_id)
          end
        end

        food.save

        answer FoodRepresenter.new(food)
      end
    end
  end
end
