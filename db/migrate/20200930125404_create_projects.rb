class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.decimal :price, default: 0, precision: 8, scale: 2
      t.string :description
      t.string :image
      t.timestamp :end_time
      t.timestamp :start_time
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
