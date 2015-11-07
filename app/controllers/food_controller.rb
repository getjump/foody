require 'multi_json'

class FoodController < ApiController
  def get
    param! :tags, Array, required: false
    param! :price, Array, required: false
    param! :device, String, required: false

    food = Food.all

    unless params[:tags].nil?
      food = food.joins(:tags)
      params[:tags].each do |tag_id|
        food = food.where("tags.id" => tag_id)
      end
    end

    unless params[:price].nil?
      price = params[:price]
      food = food.where(:price => price[0].to_i..price[1].to_i)
    end

    unless params[:device].nil?
      user = User.where(:device_hash => params[:device]).take
      food.each do |f|
        f.user = user
      end
    end

    food = food.sort {|x, y|
      (y.ratings_count[:tried] + y.ratings_count[:liked]) <=> (x.ratings_count[:tried] + x.ratings_count[:liked])
    }

    answer FoodCollectionRepresenter.new(food)
  end

  def post
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
