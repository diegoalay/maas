require "test_helper"

class Shift::AvailablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shift_available = shift_availables(:one)
  end

  test "should get index" do
    get shift_availables_url
    assert_response :success
  end

  test "should get new" do
    get new_shift_available_url
    assert_response :success
  end

  test "should create shift_available" do
    assert_difference('Shift::Available.count') do
      post shift_availables_url, params: { shift_available: {  } }
    end

    assert_redirected_to shift_available_url(Shift::Available.last)
  end

  test "should show shift_available" do
    get shift_available_url(@shift_available)
    assert_response :success
  end

  test "should get edit" do
    get edit_shift_available_url(@shift_available)
    assert_response :success
  end

  test "should update shift_available" do
    patch shift_available_url(@shift_available), params: { shift_available: {  } }
    assert_redirected_to shift_available_url(@shift_available)
  end

  test "should destroy shift_available" do
    assert_difference('Shift::Available.count', -1) do
      delete shift_available_url(@shift_available)
    end

    assert_redirected_to shift_availables_url
  end
end
