class RemoveColumnDescriptionFromTask < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :description
  end
end
