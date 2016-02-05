require 'test_helper'

class WinnersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
