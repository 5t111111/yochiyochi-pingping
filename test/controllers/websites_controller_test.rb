require 'test_helper'

class WebsitesControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get show" do
    get :show, id: 1
    assert_response :success
  end

  #test "should post create" do
  #  post :create, "url" => 'http://example.com'
  #  assert_response :success
  #end
end
