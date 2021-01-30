class CreateUserTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :user_tasks do |t|

      t.integer :task_id
      t.integer :user_id

      t.integer :status

      t.timestamps
    end
  end
end
