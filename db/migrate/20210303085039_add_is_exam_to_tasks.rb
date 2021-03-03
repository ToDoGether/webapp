class AddIsExamToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :is_exam, :boolean, default: :false
  end
end
