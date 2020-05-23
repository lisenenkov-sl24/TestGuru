class AddFirstNameLastNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string, limit: 200, null: true
    add_column :users, :last_name, :string, limit: 200, null: true
  end
end
