require 'test_helper'

module Api
  module V1
    class PlacesControllerTest < ActionController::TestCase
      test "should get places" do
        get "get"
        assert_response :success
      end

      test "should create place" do
        assert_difference('Place.count') do
          post "post", :name => "test", :address => "test", :location => [43.125356, 131.957655]
        end
      end
    end
  end
end
