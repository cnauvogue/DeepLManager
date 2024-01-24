class CreateTranslations < ActiveRecord::Migration[7.1]
  def change
    create_table :translations do |t|
      t.string :original

      t.timestamps
    end
  end
end
