require 'securerandom'

module Api
  module V1
    class PhotosController < ApiController

      api! 'Return photo by id'
      meta :object => {
        :id => "int",
        :urls => {
          :original => "string",
          :medium => "string",
          :thumb => "string",
          :square => "string"
        }
      }
      param :photo, :number, desc: 'Photo id', required: true

      def get
        photo = Photo.find(params[:photo])
        answer PhotoRepresenter.new(photo)
      end

      api! 'Upload photo'
      meta :object => {
        :id => "int",
        :urls => {
          :original => "string",
          :medium => "string",
          :thumb => "string",
          :square => "string"
        }
      }
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
  end
end
