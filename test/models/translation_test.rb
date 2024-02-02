require 'test_helper'

class TranslationTest < ActiveSupport::TestCase
  # test 'the truth' do
  #   assert true
  # end
  test 'should not save without a translated term' do
    translation = Translation.new
    translation.language = languages(:french)
    translation.term = terms(:GDPR)
    assert_not translation.save
  end

  test 'should not save without a language' do
    translation = Translation.new
    translation.term = terms(:GDPR)
    translation.translated_term = 'PDGR'
    assert_not translation.save
  end

  test 'should not save without an original term' do
    translation = Translation.new
    translation.translated_term = 'PDGR'
    translation.language = languages(:french)
    assert_not translation.save
  end
end
