class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.integer :action, null: false, index: true
      t.string :message, null: false
      t.boolean :read, default: false, index: true

      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
