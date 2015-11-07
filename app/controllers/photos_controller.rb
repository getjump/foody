require 'securerandom'

class PhotosController < ApiController
  skip_before_action :verify_authenticity_token

  def get
    param! :photo, Integer, required: true

    photo = Photo.find(params[:photo])

    answer photo.fetch
  end

  def post
    # param! :photo, required: true

    photo = params[:photo]
    data = StringIO.new(Base64.decode64(photo))
    data.class.class_eval { attr_accessor :original_filename, :content_type }
    data.original_filename = SecureRandom.hex + ".png"
    data.content_type = "image/png"

    ph = Photo.new
    ph.photo = data
    ph.save

    answer PhotoRepresenter.new(ph)
  end
end
