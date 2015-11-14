require 'securerandom'

class PhotosController < ApiController
  skip_before_action :verify_authenticity_token

  resource_description do
    formats [:json]
  end

  api :GET, '/photos', 'Return photo by id'
  param :photo, :number, desc: 'Photo id', required: true
  def get
    photo = Photo.find(params[:photo])
    answer photo.fetch
  end

  api :POST, '/photos', 'Upload photo'
  param :photo, String, desc: 'Base64 encoded photo', required: true
  def post
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
