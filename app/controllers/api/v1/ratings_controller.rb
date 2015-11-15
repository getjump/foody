module Api
  module V1
    class RatingsController < ApiController

      api! 'Add like'
      description 'Add like to object'
      meta :object =>
      {
        :status => "int"
      }
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

      api! 'Remove like'
      description 'Remove like from object'
      meta :object =>
      {
        :sucess => "bool"
      }
      param :food, :number, desc: 'Id of food', required: true
      param :device, String, desc: 'Device hash', required: true

      def delete
        Rating.where(:food => params[:food], :user => User.where(:device_hash => params[:device]).take).take.destroy
        answer :sucess => true
      end
    end
  end
end
