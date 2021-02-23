class ChangeDatetimeTypeForDuedate < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :duedate, :datetime
  end
end
