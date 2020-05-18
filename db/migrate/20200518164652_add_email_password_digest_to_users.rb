class AddEmailPasswordDigestToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email, :string, limit: 200
    add_column :users, :password_digest, :string, limit: 200
  end
end
