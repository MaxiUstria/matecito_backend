class AddCategoryToPosts < ActiveRecord::Migration[7.0]
  def change
    change_table :posts, bulk: true do |t|
      t.string :url
      t.integer :category, null: false, default: 0
    end
  end
end
