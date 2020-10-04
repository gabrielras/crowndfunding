class Donation < ApplicationRecord
  belongs_to :client
  belongs_to :project

  enum status: {
    processing: 0,
    authorized: 1,
    paid: 2,
    refunded: 3,
    refused: 4,
    chargedback: 5,
    analyzing: 6,
    pending_review: 7,
    error_in_transaction: 10
  }

  
end
