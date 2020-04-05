class SetDefaultCorrectToAnswer < ActiveRecord::Migration[5.2]
  def change
    change_column_default :answers, :correct, from: :null, to: false
  end
end
