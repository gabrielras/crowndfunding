class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :bank_code
      t.string :agency
      t.string :account
      t.string :agency_dv
      t.string :account_dv
      t.string :account_type
      t.string :legal_name
      t.string :document_number
      t.string :bank_id
      t.string :recipient_id
      t.references :client, null: false, foreign_key: true
      t.timestamps
    end
  end
end
