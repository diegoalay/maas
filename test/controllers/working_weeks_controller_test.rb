require "test_helper"

class WorkingWeeksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @working_week = working_weeks(:one)
  end

  test "should get index" do
    get working_weeks_url
    assert_response :success
  end

  test "should get new" do
    get new_working_week_url
    assert_response :success
  end

  test "should create working_week" do
    assert_difference('WorkingWeek.count') do
      post working_weeks_url, params: { working_week: {  } }
    end

    assert_redirected_to working_week_url(WorkingWeek.last)
  end

  test "should show working_week" do
    get working_week_url(@working_week)
    assert_response :success
  end

  test "should get edit" do
    get edit_working_week_url(@working_week)
    assert_response :success
  end

  test "should update working_week" do
    patch working_week_url(@working_week), params: { working_week: {  } }
    assert_redirected_to working_week_url(@working_week)
  end

  test "should destroy working_week" do
    assert_difference('WorkingWeek.count', -1) do
      delete working_week_url(@working_week)
    end

    assert_redirected_to working_weeks_url
  end
end
