require "test_helper"

class CurrentUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get current_users_show_url
    assert_response :success
  end

  test "should get edit" do
    get current_users_edit_url
    assert_response :success
  end
end
