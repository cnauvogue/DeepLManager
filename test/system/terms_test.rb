require "application_system_test_case"

class TermsTest < ApplicationSystemTestCase
  setup do
    @term = terms(:GDPR)
  end

  test "visiting the index" do
    visit terms_url
    assert_selector "h1", text: "Terms"
    list = page.all("div.terms_list div.term_detail a.term_original").map(&:text)
    assert list == [
      "ADSF",
      "GDPR",
      "GFJKH",
      "HTTD",
      "LSAD",
      "QEWR",
      "SHGD",
      "WFV",
      "XVB",
      "YERUT"
    ]
  end

  test "should create term" do
    visit terms_url
    click_on "New term"

    fill_in "Original", with: @term.original
    click_on "Create Term"

    assert_text "Term was successfully created"
    click_on "Back"
  end

  test "should update Term" do
    visit term_url(@term)
    click_on "Edit this term", match: :first

    fill_in "Original", with: @term.original
    click_on "Update Term"

    assert_text "Term was successfully updated"
    click_on "Back"
  end

  test "should destroy Term" do
    visit term_url(@term)
    click_on "Destroy this term", match: :first

    assert_text "Term was successfully destroyed"
  end
end
