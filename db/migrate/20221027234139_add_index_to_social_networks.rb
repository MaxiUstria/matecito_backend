class AddIndexToSocialNetworks < ActiveRecord::Migration[7.0]
  def change
    add_index :social_networks, %i[user_id app], unique: true
  end
end
