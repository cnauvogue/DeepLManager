require "test_helper"

class LanguageTest < ActiveSupport::TestCase
  test "can save without translations" do
    lang = Language.new
    assert lang.save
  end

  test "can destroy, chaining to translations" do
    lang = languages(:french)
    assert lang.destroy
  end
end
