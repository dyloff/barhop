require "test_helper"

class CrawlbarsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get crawlbars_create_url
    assert_response :success
  end
end
