# frozen_string_literal: true

class UpdateForeignKeyAddOnDeleteConstraint < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :weblinks, :tasks
    add_foreign_key :weblinks, :tasks, on_delete: :cascade
  end
end
