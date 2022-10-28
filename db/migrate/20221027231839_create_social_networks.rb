class CreateSocialNetworks < ActiveRecord::Migration[7.0]
  def change
    create_table :social_networks do |t|
      t.string  :url, null: false
      t.integer :app, null: false

      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
