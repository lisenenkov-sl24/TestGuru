class AddTypeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :type, :string, limit: 20, null: false, default: 'User'
  end
end
