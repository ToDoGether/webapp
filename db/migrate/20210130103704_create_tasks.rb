class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.timestamp :duedate
      t.integer :worktype
      t.string :description

      t.timestamps
    end
  end
end
