class AddUniqueConstraintOnTranslations < ActiveRecord::Migration[7.1]
  def change
    add_index :translations, [:term_id, :language_id], unique: true
  end
end
