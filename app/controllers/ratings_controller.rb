class RatingsController < ApiController
  def post
    param! :food, Integer, required: true
    param! :type, Integer, required: true
    param! :device, String, required: true

    rating = Rating.new
    rating.food_id = params[:food]
    rating.device = params[:device]
    rating.type = params[:type]
  end
end
