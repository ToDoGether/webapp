class CreateWeblinks < ActiveRecord::Migration[6.1]
  def change
    create_table :weblinks do |t|
      t.string :name
      t.string :url
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
