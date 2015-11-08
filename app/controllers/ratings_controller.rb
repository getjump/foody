class RatingsController < ApiController
  skip_before_action :verify_authenticity_token

  def post
    param! :food, Integer, required: true
    param! :status, Integer, required: true
    param! :device, String, required: true

    rating = Rating.new
    rating.food_id = params[:food]
    rating.user = User.where(:device_hash => params[:device]).take
    rating.status = params[:status]
    rating.save

    answer LikesRepresenter.new(rating)
  end

  def delete
    param! :food, Integer, required: true
    param! :device, String, required: true

    rating.where(:food => params[:food], :device => params[:device]).take.destroy

    answer :sucess => true
  end
end
