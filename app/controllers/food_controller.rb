require 'multi_json'

class FoodController < ApiController
  skip_before_action :verify_authenticity_token

  def get
    param! :search, Array, required: false
    param! :tags, Array, required: false
    param! :price, Array, required: false
    param! :device, String, required: false
    param! :count, Integer, required: false, min: 0
    param! :offset, Integer, required: false, min: 0

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
      params[:tags].each do |tag_id|
        count = count.where("tags.id" => tag_id)
        food = food.where("tags.id" => tag_id)
      end
    end

    unless params[:price].nil?
      price = params[:price]
      count = count.where(:price => price[0].to_i..price[1].to_i)
      food = food.where(:price => price[0].to_i..price[1].to_i)
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

  def post
    # /food?tags[]=1&tags[]=2
    param! :tags, Array
    param! :name, String, required: true
    param! :price, Integer, required: true
    param! :photo, Integer, required: true
    param! :place, Integer, required: true

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
