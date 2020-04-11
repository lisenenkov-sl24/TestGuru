class RemoveUserFromAnswer < ActiveRecord::Migration[5.2]
  def change
    remove_reference :answers, :user, index: true, foreign_key: true
  end
end
