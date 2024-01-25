class AddLanguageRefToTranslation < ActiveRecord::Migration[7.1]
  def change
    add_reference :translations, :languages, foreign_key: true
    remove_column :translations, :original
    add_column :translations, :translated_term, :string
  end
end
