class Pagarme::CreateBankAccountService
  require 'pagarme'

  PagarMe.api_key        = ENV['PAGARME_API_KEY']
  PagarMe.encryption_key = ENV['PAGARME_ENCRYPTION_KEY']

  def initialize(params)
    @profile = params[:profile]
  end
  
  def call
    bank_account = PagarMe::BankAccount.new({
      :bank_code => @profile.bank_code,
      :agencia => @profile.agency,
      :agencia_dv => @profile.agency_dv,
      :conta => @profile.account,
      :conta_dv => @profile.account_dv,
      :legal_name => @profile.legal_name,
      :document_number => @profile.document_number
    })
    bank_account.create
  end

end
