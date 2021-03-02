# frozen_string_literal: true

class AddColorToSubjects < ActiveRecord::Migration[6.1]
  def change
    add_column :subjects, :color, :string, default: '#000000'
  end
end
