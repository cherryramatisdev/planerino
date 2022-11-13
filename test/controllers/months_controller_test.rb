require "test_helper"

class MonthsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @month = months(:one)
  end

  test "should get index" do
    get months_url
    assert_response :success
  end

  test "should get new" do
    get new_month_url
    assert_response :success
  end

  test "should create month" do
    assert_difference("Month.count") do
      post months_url, params: { month: { name: @month.name } }
    end

    assert_redirected_to month_url(Month.last)
  end

  test "should show month" do
    get month_url(@month)
    assert_response :success
  end

  test "should get edit" do
    get edit_month_url(@month)
    assert_response :success
  end

  test "should update month" do
    patch month_url(@month), params: { month: { name: @month.name } }
    assert_redirected_to month_url(@month)
  end

  test "should destroy month" do
    assert_difference("Month.count", -1) do
      delete month_url(@month)
    end

    assert_redirected_to months_url
  end
end
