class CreateLanguages < ActiveRecord::Migration[7.1]
  def change
    create_table :languages do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end
