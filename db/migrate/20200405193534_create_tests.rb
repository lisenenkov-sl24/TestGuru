class CreateTests < ActiveRecord::Migration[5.2]
  def change
    create_table :tests do |t|
      t.string :title, limit: 200, null: false
      t.integer :level, null: false
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
