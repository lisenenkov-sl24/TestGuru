class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.string :title, limit: 200, null: false
      t.string :image_name, limit: 200, null: false
      t.string :type, limit: 30, null: false

      t.references :parameter_category, foreign_key: { to_table: :categories }, null: true
      t.integer :parameter_number, null: true
      t.string :parameter_string, null: true

      t.timestamps
    end

    create_table :user_badges do |t|
      t.references :user, foreign_key: true, null: false
      t.references :badge, foreign_key: true, null: false

      t.timestamps
    end
  end
end
