class AddIsNpoToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_npo?, :boolean
  end
end
