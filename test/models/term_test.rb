require "test_helper"

class TermTest < ActiveSupport::TestCase
  test "can save without translations" do
    term = Term.new
    assert term.save
  end

  test "can destroy, chaining to translations" do
    term = terms(:GDPR)
    assert term.destroy
  end
end
