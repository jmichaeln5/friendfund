require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get users sign in path" do
    get new_user_session_path
    assert_response :success
  end

  test "should get users registration path" do
    get new_user_registration_path
    assert_response :success
  end

  test "should get users path" do
    get users_url
    assert_response :redirect
  end

end
