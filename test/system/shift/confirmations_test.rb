require "application_system_test_case"

class Shift::ConfirmationsTest < ApplicationSystemTestCase
  setup do
    @shift_confirmation = shift_confirmations(:one)
  end

  test "visiting the index" do
    visit shift_confirmations_url
    assert_selector "h1", text: "Shift/Confirmations"
  end

  test "creating a Confirmation" do
    visit shift_confirmations_url
    click_on "New Shift/Confirmation"

    click_on "Create Confirmation"

    assert_text "Confirmation was successfully created"
    click_on "Back"
  end

  test "updating a Confirmation" do
    visit shift_confirmations_url
    click_on "Edit", match: :first

    click_on "Update Confirmation"

    assert_text "Confirmation was successfully updated"
    click_on "Back"
  end

  test "destroying a Confirmation" do
    visit shift_confirmations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Confirmation was successfully destroyed"
  end
end
