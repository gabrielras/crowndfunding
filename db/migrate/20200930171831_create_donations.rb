class CreateDonations < ActiveRecord::Migration[6.0]
  def change
    create_table :donations do |t|
      t.references :client, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.string :comment
      t.decimal :price_paid, default: 0, precision: 8, scale: 2
      t.timestamps
    end
  end
end
