require "application_system_test_case"

class LanguagesTest < ApplicationSystemTestCase
  setup do
    @language = languages(:french)
  end

  test "visiting the index" do
    visit languages_url
    assert_selector "h1", text: "Languages"
  end

  test "should create language" do
    visit languages_url
    click_on "New language"

    fill_in "Code", with: @language.code
    fill_in "Name", with: @language.name
    click_on "Create Language"

    assert_text "\"#{@language.name}\" was successfully created"
  end

  test "should update Language" do
    visit language_url(@language)
    click_on "Edit this language", match: :first

    fill_in "Code", with: @language.code
    fill_in "Name", with: @language.name
    click_on "Update Language"

    assert_text "\"#{@language.name}\" was successfully updated"
  end

  test "should destroy Language" do
    visit language_url(@language)
    accept_alert do
      click_on "Delete language", match: :first
    end


    assert_text "\"#{@language.name}\" was successfully destroyed"
  end
end
