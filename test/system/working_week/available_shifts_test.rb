require "application_system_test_case"

class WorkingWeek::AvailableShiftsTest < ApplicationSystemTestCase
  setup do
    @working_week_available_shift = working_week_available_shifts(:one)
  end

  test "visiting the index" do
    visit working_week_available_shifts_url
    assert_selector "h1", text: "Working Week/Available Shifts"
  end

  test "creating a Available shift" do
    visit working_week_available_shifts_url
    click_on "New Working Week/Available Shift"

    click_on "Create Available shift"

    assert_text "Available shift was successfully created"
    click_on "Back"
  end

  test "updating a Available shift" do
    visit working_week_available_shifts_url
    click_on "Edit", match: :first

    click_on "Update Available shift"

    assert_text "Available shift was successfully updated"
    click_on "Back"
  end

  test "destroying a Available shift" do
    visit working_week_available_shifts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Available shift was successfully destroyed"
  end
end
