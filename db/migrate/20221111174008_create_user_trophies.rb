class CreateUserTrophies < ActiveRecord::Migration[7.0]
  def change
    create_table :user_trophies do |t|
      t.boolean :active, null: false, default: true

      t.references :user, null: false, foreign_key: true
      t.references :trophy, null: false, foreign_key: true

      t.index %i[user_id trophy_id], unique: true
      t.timestamps
    end
  end
end
