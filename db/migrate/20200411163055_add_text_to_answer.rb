class AddTextToAnswer < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :text, :string,  limit: 300, null: false, default: ''
  end
end
