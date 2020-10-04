class Profile < ApplicationRecord
  belongs_to :client

  validates :state, presence: true
  validates :city, presence: true
  validates :neighborhood, presence: true
  validates :street, presence: true
  validates :street_number, presence: true
  validates :zipcode, presence: true

  validates :bank_code, presence: true
  validates :agency, presence: true
  validates :agency_dv, presence: true
  validates :account_dv, presence: true
  validates :account_type, presence: true
  validates :legal_name, presence: true
  validates :document_number, presence: true
end
