require "application_system_test_case"

class Shift::AvailablesTest < ApplicationSystemTestCase
  setup do
    @shift_available = shift_availables(:one)
  end

  test "visiting the index" do
    visit shift_availables_url
    assert_selector "h1", text: "Shift/Availables"
  end

  test "creating a Available" do
    visit shift_availables_url
    click_on "New Shift/Available"

    click_on "Create Available"

    assert_text "Available was successfully created"
    click_on "Back"
  end

  test "updating a Available" do
    visit shift_availables_url
    click_on "Edit", match: :first

    click_on "Update Available"

    assert_text "Available was successfully updated"
    click_on "Back"
  end

  test "destroying a Available" do
    visit shift_availables_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Available was successfully destroyed"
  end
end
