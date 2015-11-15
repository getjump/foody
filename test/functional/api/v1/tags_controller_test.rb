require 'test_helper'

module Api
  module V1
    class TagsControllerTest < ActionController::TestCase
      test "should get tags" do
        get "get"
        assert_response :success
      end

      test "should create tag" do
        assert_difference('Tag.count') do
          post "post", :name => "test"
        end
      end
    end
  end
end
