require 'multi_json'

class FoodController < ApiController
  skip_before_action :verify_authenticity_token

  resource_description do
    formats [:json]
  end

  api :GET, '/food', 'Get food'
  description 'Return basic feed'
  param :search, String, desc: 'String to search for in database'
  param :tags, Array, desc: 'Array of tags ids to lookup for items with that tags'
  param :price, Hash, desc: 'Price array' do
    param :min, :number, desc: 'Minimal price'
    param :max, :number, desc: 'Maximal price'
  end
  param :count, :number, desc: 'Count of elements to get', min: 0, max: 100
  param :offset, :number, descs: 'Offset to get elements from', min: 0

  def get
    count = Food.all

    unless params[:search].nil?
      food = Food.search_by_name(params[:search]).group("#{PgSearch::Configuration.alias('foods')}.rank").top
      count = Food.search_by_name(params[:search]).group("#{PgSearch::Configuration.alias('foods')}.rank, foods.id")
    else
      food = Food.top
    end

    unless params[:count].nil?
      food = food.limit(params[:count])
    end

    unless params[:offset].nil?
      food = food.offset(params[:offset]);
    end

    unless params[:tags].nil?
      food = food.joins(:tags)
      count = count.joins(:tags)
      params[:tags].each do |tag_id|
        count = count.where("tags.id" => tag_id)
        food = food.where("tags.id" => tag_id)
      end
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

    fc.items = food

    unless count.count.class == Fixnum
      fc.count = count.count.length
    else
      fc.count = count.count
    end

    obj = FoodCollectionRepresenter.new(fc)

    answer obj
  end

  api :POST, '/food', 'Create food'
  description 'Create food'
  param :name, String, desc: 'Name that should be assigned to food', required: true
  param :photo, Integer, desc: 'Id of photo that should be assigned to food', required: true
  param :place, Integer, desc: 'Id of place that should be assigned to food', required: true
  param :price, Integer, desc: 'Price of food', required: true
  param :tags, Array, desc: 'Array of tags ids to add for food' do
    param "", Integer, desc: 'Tag id'
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
