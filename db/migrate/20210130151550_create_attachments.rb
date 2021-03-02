# frozen_string_literal: true

class CreateAttachments < ActiveRecord::Migration[6.1]
  def change
    create_table :attachments do |t|
      t.string :filename
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
