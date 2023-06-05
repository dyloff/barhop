require "test_helper"

class CrawlsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get crawls_home_url
    assert_response :success
  end

  test "should get index" do
    get crawls_index_url
    assert_response :success
  end

  test "should get new" do
    get crawls_new_url
    assert_response :success
  end

  test "should get create" do
    get crawls_create_url
    assert_response :success
  end
end
