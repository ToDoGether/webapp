# frozen_string_literal: true

class AddSubjectToTasks < ActiveRecord::Migration[6.1]
  def change
    add_reference :tasks, :subject, null: false, foreign_key: true
  end
end
