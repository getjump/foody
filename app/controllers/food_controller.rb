class FoodController < ApiController
  def get
    param! :tags
    param! :price
    param! :device, String
  end

  def post
    param! :tags
    param! :price, Integer, required: true
    param! :photo, Integer, required: true
    param! :place, Integer, required: true
  end
end
