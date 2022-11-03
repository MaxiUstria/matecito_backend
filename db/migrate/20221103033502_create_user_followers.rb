class CreateUserFollowers < ActiveRecord::Migration[7.0]
  def change
    create_table :user_followers do |t|
      t.references :follower, null: false, foreign_key: { to_table: :users }
      t.references :user, null: false, index: true, foreign_key: true

      t.index %i[follower_id user_id], unique: true
      t.timestamps
    end
  end
end
