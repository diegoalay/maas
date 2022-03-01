require "test_helper"

class Shift::ConfirmationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shift_confirmation = shift_confirmations(:one)
  end

  test "should get index" do
    get shift_confirmations_url
    assert_response :success
  end

  test "should get new" do
    get new_shift_confirmation_url
    assert_response :success
  end

  test "should create shift_confirmation" do
    assert_difference('Shift::Confirmation.count') do
      post shift_confirmations_url, params: { shift_confirmation: {  } }
    end

    assert_redirected_to shift_confirmation_url(Shift::Confirmation.last)
  end

  test "should show shift_confirmation" do
    get shift_confirmation_url(@shift_confirmation)
    assert_response :success
  end

  test "should get edit" do
    get edit_shift_confirmation_url(@shift_confirmation)
    assert_response :success
  end

  test "should update shift_confirmation" do
    patch shift_confirmation_url(@shift_confirmation), params: { shift_confirmation: {  } }
    assert_redirected_to shift_confirmation_url(@shift_confirmation)
  end

  test "should destroy shift_confirmation" do
    assert_difference('Shift::Confirmation.count', -1) do
      delete shift_confirmation_url(@shift_confirmation)
    end

    assert_redirected_to shift_confirmations_url
  end
end
