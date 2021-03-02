# frozen_string_literal: true

class ChangeDataTypeForWorkType < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :worktype, 'boolean USING (CASE WHEN worktype > 0 THEN TRUE ELSE FALSE END)'
  end
end
