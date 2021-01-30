class CreateTeamUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :team_users do |t|

      t.integer :user_id
      t.integer :team_id

      t.boolean :is_admin

      t.timestamps
    end
  end
end
