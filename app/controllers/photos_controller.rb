class PhotosController < ApiController
  def get
    param! :photo, Integer, required: true
  end

  def post
    param! :photo, required: true
  end
end
