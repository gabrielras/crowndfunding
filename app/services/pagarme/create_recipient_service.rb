class Pagarme::CreateRecipientService
  require 'pagarme'

  PagarMe.api_key        = ENV['PAGARME_API_KEY']
  PagarMe.encryption_key = ENV['PAGARME_ENCRYPTION_KEY']

  def initialize(params)
    @profile = params[:profile]
  end

  def call
    recipient = PagarMe::Recipient.new({
      :anticipatable_volume_percentage => 90, 
      :automatic_anticipation_enabled => true, 
      :bank_account_id =>  @profile.bank_id, 
      :transfer_day => "4", 
      :transfer_enabled => true, 
      :transfer_interval => "weekly"
    }).create
  end

end
