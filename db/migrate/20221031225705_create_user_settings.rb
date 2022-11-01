class CreateUserSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :user_settings do |t|
      t.integer :category, null: false, default: 0
      t.string :value, null: false

      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
