require "application_system_test_case"

class ExaminationsTest < ApplicationSystemTestCase
  setup do
    @examination = examinations(:one)
  end

  test "visiting the index" do
    visit examinations_url
    assert_selector "h1", text: "Examinations"
  end

  test "creating a Examination" do
    visit examinations_url
    click_on "New Examination"

    fill_in "Examinated At", with: @examination.examinated_at
    fill_in "Name", with: @examination.name
    fill_in "Path", with: @examination.path
    fill_in "Patient", with: @examination.patient_id
    click_on "Create Examination"

    assert_text "Examination was successfully created"
    click_on "Back"
  end

  test "updating a Examination" do
    visit examinations_url
    click_on "Edit", match: :first

    fill_in "Examinated At", with: @examination.examinated_at
    fill_in "Name", with: @examination.name
    fill_in "Path", with: @examination.path
    fill_in "Patient", with: @examination.patient_id
    click_on "Update Examination"

    assert_text "Examination was successfully updated"
    click_on "Back"
  end

  test "destroying a Examination" do
    visit examinations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Examination was successfully destroyed"
  end
end
