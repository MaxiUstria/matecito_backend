class CreateObjectives < ActiveRecord::Migration[7.0]
  def change
    create_table :objectives do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :state, null: false, default: 'active'
      t.date   :start_date, null: false
      t.date   :end_date
      t.integer :target_amount, null: false
      t.integer :current_amount, null: false, default: 0

      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
