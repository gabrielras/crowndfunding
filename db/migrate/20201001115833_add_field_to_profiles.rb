class AddFieldToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :state, :string
    add_column :profiles, :city, :string
    add_column :profiles, :neighborhood, :string
    add_column :profiles, :street, :string
    add_column :profiles, :street_number, :string
    add_column :profiles, :zipcode, :string    
  end
end
