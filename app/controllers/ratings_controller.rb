class RatingsController < ApiController
  skip_before_action :verify_authenticity_token

  resource_description do
    formats [:json]
  end

  api :POST, '/ratings', 'Add like'
  description 'Add like to object'
  param :food, :number, desc: 'Id of food', required: true
  param :status, :number, desc: 'Like type, 0 - tried, 1 - liked', required: true
  param :device, String, desc: 'Device hash to associate like with', required: true
  def post
    rating = Rating.new
    rating.food_id = params[:food]
    rating.user = User.where(:device_hash => params[:device]).take
    rating.status = params[:status]
    rating.save

    answer LikesRepresenter.new(rating)
  end

  api :DELETE, '/ratings', 'Remove like'
  description 'Remove like from object'
  param :food, :number, desc: 'Id of food', required: true
  param :device, String, desc: 'Device hash', required: true
  def delete
    rating.where(:food => params[:food], :device => params[:device]).take.destroy
    answer :sucess => true
  end
end
