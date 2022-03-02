require "application_system_test_case"

class WorkingWeek::ConfirmedShiftsTest < ApplicationSystemTestCase
  setup do
    @working_week_confirmed_shift = working_week_confirmed_shifts(:one)
  end

  test "visiting the index" do
    visit working_week_confirmed_shifts_url
    assert_selector "h1", text: "Working Week/Confirmed Shifts"
  end

  test "creating a Confirmed shift" do
    visit working_week_confirmed_shifts_url
    click_on "New Working Week/Confirmed Shift"

    click_on "Create Confirmed shift"

    assert_text "Confirmed shift was successfully created"
    click_on "Back"
  end

  test "updating a Confirmed shift" do
    visit working_week_confirmed_shifts_url
    click_on "Edit", match: :first

    click_on "Update Confirmed shift"

    assert_text "Confirmed shift was successfully updated"
    click_on "Back"
  end

  test "destroying a Confirmed shift" do
    visit working_week_confirmed_shifts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Confirmed shift was successfully destroyed"
  end
end
