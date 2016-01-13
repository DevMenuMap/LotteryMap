require 'test_helper'

class CrawlersControllerTest < ActionController::TestCase
  test "should get google" do
    get :google
    assert_response :success
  end
end
