class CreateDonations < ActiveRecord::Migration[7.0]
  def change
    create_table :donations do |t|
      t.integer :amount, null: false
      t.string :currency, null: false, default: 'UY'
      t.string :message

      t.references :beneficiary, null: false, foreign_key: { to_table: :users }, index: true
      t.references :donor, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
