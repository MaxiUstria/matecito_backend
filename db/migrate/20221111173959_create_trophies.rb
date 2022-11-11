class CreateTrophies < ActiveRecord::Migration[7.0]
  def change
    create_table :trophies do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :description, null: false
      t.integer :category, null: false

      t.timestamps
    end
  end
end
