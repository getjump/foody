class PhotosController < ApiController
  skip_before_action :verify_authenticity_token

  def get
    param! :photo, Integer, required: true

    answer PhotoRepresenter.new(Photo.find(params[:photo]))
  end

  def post
    # param! :photo, required: true

    ph = Photo.new
    ph.photo = params[:photo]
    ph.save
  end
end
