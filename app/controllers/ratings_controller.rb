class RatingsController < ApiController
  def post
    param! :food, Integer, required: true
    param! :status, Integer, required: true
    param! :device, String, required: true

    rating = Rating.new
    rating.food_id = params[:food]
    rating.user = User.where(:device_hash => params[:device])
    rating.status = params[:status]
  end
end
