class AddTermRefToTranslations < ActiveRecord::Migration[7.1]
  def change
    add_reference :translations, :term, null: false, foreign_key: true
  end
end
