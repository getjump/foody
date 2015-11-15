require 'test_helper'

module Api
  module V1
    class FoodControllerTest < ActionController::TestCase
      test "should get food" do
        get "get", :device => "android"
        assert_response :success
      end

      test "should limit count" do
        get "get", :count => 2000
        assert_response 500
        get "get", :count => -1
        assert_response 500
      end

      test "should create food" do
        assert_difference('Food.count') do
          photo = photos(:Photo_11)
          place = places(:Place_696)
          post "post", :name => "Test", :photo => photo.id, :place => place.id, :price => 1337
        end
      end
    end
  end
end
