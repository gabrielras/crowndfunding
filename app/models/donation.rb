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
    error_in_transaction: 10,
    pending: 11
  }

  validates :price_paid, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :status, presence: true
end
