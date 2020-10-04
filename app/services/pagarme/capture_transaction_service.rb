class Pagarme::CaptureTransactionService
  require 'pagarme'

  PagarMe.api_key        = ENV['PAGARME_API_KEY']
  PagarMe.encryption_key = ENV['PAGARME_ENCRYPTION_KEY']

  def initialize(params)
    @donation = params[:donation]
  end

  def call
    transaction = PagarMe::Transaction.find_by_id(@donation.transaction_id)
    transaction.capture({:amount => (@donation.price_paid*100).to_i})
  end
end
