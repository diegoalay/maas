require "test_helper"

class WorkingWeek::ConfirmedShiftsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @working_week_confirmed_shift = working_week_confirmed_shifts(:one)
  end

  test "should get index" do
    get working_week_confirmed_shifts_url
    assert_response :success
  end

  test "should get new" do
    get new_working_week_confirmed_shift_url
    assert_response :success
  end

  test "should create working_week_confirmed_shift" do
    assert_difference('WorkingWeek::ConfirmedShift.count') do
      post working_week_confirmed_shifts_url, params: { working_week_confirmed_shift: {  } }
    end

    assert_redirected_to working_week_confirmed_shift_url(WorkingWeek::ConfirmedShift.last)
  end

  test "should show working_week_confirmed_shift" do
    get working_week_confirmed_shift_url(@working_week_confirmed_shift)
    assert_response :success
  end

  test "should get edit" do
    get edit_working_week_confirmed_shift_url(@working_week_confirmed_shift)
    assert_response :success
  end

  test "should update working_week_confirmed_shift" do
    patch working_week_confirmed_shift_url(@working_week_confirmed_shift), params: { working_week_confirmed_shift: {  } }
    assert_redirected_to working_week_confirmed_shift_url(@working_week_confirmed_shift)
  end

  test "should destroy working_week_confirmed_shift" do
    assert_difference('WorkingWeek::ConfirmedShift.count', -1) do
      delete working_week_confirmed_shift_url(@working_week_confirmed_shift)
    end

    assert_redirected_to working_week_confirmed_shifts_url
  end
end
