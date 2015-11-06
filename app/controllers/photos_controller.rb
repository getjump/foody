class PhotosController < ApiController
  skip_before_action :verify_authenticity_token

  def get
    param! :photo, Integer, required: true

    answer PhotoRepresenter.new(Photo.find(params[:photo]))
  end

  def post
    # param! :photo, required: true

    photo = params[:photo]

    ph = Photo.new
    ph.photo = photo
    ph.save
  end
end
