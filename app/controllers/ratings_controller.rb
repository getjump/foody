class RatingsController < ApiController
  def post
    param! :food, Integer, required: true
    param! :type, Integer, required: true
    param! :device, String, required: true
  end
end
