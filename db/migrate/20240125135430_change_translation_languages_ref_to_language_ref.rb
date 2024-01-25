class ChangeTranslationLanguagesRefToLanguageRef < ActiveRecord::Migration[7.1]
  def change
    remove_reference :translations, :languages
    add_reference :translations, :language, null: false, foreign_key: true
  end
end
