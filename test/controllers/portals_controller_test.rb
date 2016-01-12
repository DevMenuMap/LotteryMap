require 'test_helper'

class PortalsControllerTest < ActionController::TestCase
  test "should get news" do
    get :news
    assert_response :success
  end

end
