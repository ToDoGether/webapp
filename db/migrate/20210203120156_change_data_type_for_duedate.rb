class ChangeDataTypeForDuedate < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :duedate, :date
  end
end
