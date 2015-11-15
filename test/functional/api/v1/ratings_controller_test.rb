require 'test_helper'

module Api
  module V1
    class RatingsControllerTest < ActionController::TestCase
      test "should set like" do
        assert_difference('Rating.count') do
          post "post", :food => 7, :status => 0, :device => "ios"
        end
      end

      test "should remove like" do
        assert_difference('Rating.count', -1) do
          delete "delete", :food => 7, :device => "ios"
        end
      end
    end
  end
end
