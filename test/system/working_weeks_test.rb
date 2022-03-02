require "application_system_test_case"

class WorkingWeeksTest < ApplicationSystemTestCase
  setup do
    @working_week = working_weeks(:one)
  end

  test "visiting the index" do
    visit working_weeks_url
    assert_selector "h1", text: "Working Weeks"
  end

  test "creating a Working week" do
    visit working_weeks_url
    click_on "New Working Week"

    click_on "Create Working week"

    assert_text "Working week was successfully created"
    click_on "Back"
  end

  test "updating a Working week" do
    visit working_weeks_url
    click_on "Edit", match: :first

    click_on "Update Working week"

    assert_text "Working week was successfully updated"
    click_on "Back"
  end

  test "destroying a Working week" do
    visit working_weeks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Working week was successfully destroyed"
  end
end
