# frozen_string_literal: true

class AddUniqueConstraintToTeamsName < ActiveRecord::Migration[6.1]
  def change
    add_index(:teams, :name, unique: true)
  end
end
