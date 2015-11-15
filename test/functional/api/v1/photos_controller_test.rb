require 'test_helper'

module Api
  module V1
    class PhotosControllerTest < ActionController::TestCase
      test "should get photo" do
        photo = photos(:Photo_11)
        get "get", :photo => photo.id
        assert_response :success
      end

      test "should create photo" do
        assert_difference('Photo.count') do
          post "post", :photo => "R0lGODlhAQABAIAAAAUEBAAAACwAAAAAAQABAAACAkQBADs"
        end
      end
    end
  end
end
