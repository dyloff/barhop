require "test_helper"

class SharedWithsControllerTest < ActionDispatch::IntegrationTest
  test "should get share" do
    get shared_withs_share_url
    assert_response :success
  end

  test "should get confirm" do
    get shared_withs_confirm_url
    assert_response :success
  end
end
