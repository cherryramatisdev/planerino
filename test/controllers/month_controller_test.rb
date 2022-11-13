require "test_helper"

class MonthControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get month_index_url
    assert_response :success
  end
end
