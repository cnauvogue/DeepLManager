class CreateDeepLGlossaries < ActiveRecord::Migration[7.1]
  def change
    create_table :deep_l_glossaries do |t|
      t.string :glossary_id
      t.string :name
      t.string :language_code
      t.timestamps
    end
  end
end
