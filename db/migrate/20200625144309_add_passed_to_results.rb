class AddPassedToResults < ActiveRecord::Migration[5.2]
  def up
    add_column :results, :passed, :boolean, null: true

    Result.update_all(%q[passed = case
      when current_question_id is not null then null
      else correct_answers >= 0.85 * answers
      end])
  end

  def down
    remove_column :results, :passed
  end
end
