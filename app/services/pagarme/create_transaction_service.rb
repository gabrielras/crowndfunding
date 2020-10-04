class Pagarme::CreateTransactionService
  require 'pagarme'

  PagarMe.api_key        = ENV['PAGARME_API_KEY']
  PagarMe.encryption_key = ENV['PAGARME_ENCRYPTION_KEY']

  def initialize(params)
    @paymnet_info = params[:paymnet_info]
    @donation = params[:donation]
  end

  def call
    transaction  = PagarMe::Transaction.new({
      amount: (@donation.price_paid.to_i)*100,
      payment_method: "credit_card",
      card_number: @paymnet_info[:card_number].gsub(/[^0-9]/, ''),
      card_holder_name: @paymnet_info[:card_holder_name],
      card_expiration_date: @paymnet_info[:card_expiration_date].gsub(/[^0-9]/, ''),
      card_cvv: @paymnet_info[:card_cvv].gsub(/[^0-9]/, ''),
      postback_url: "https://5298326e5b10.ngrok.io/get_payment_status",
      capture: true,
      installments: "1",
      customer: {
        external_id: "##{@donation.project.id}",
        name: @donation.client.name,
        type: "individual",
        country: "br",
        email: @donation.client.email,
        documents: [
          {
            type: "cpf",
            number: @paymnet_info[:cpf_number].gsub(/[^0-9]/, '')
          }
        ],
        phone_numbers: ["+55" + @paymnet_info[:phone_number].gsub(/[^0-9]/, '')]
      },
      billing: {
        name: 'Crowdfunding',
        address: {
          country: "br",
          state: @donation.project.client.profile.state,
          city: @donation.project.client.profile.city,
          neighborhood: @donation.project.client.profile.neighborhood,
          street: @donation.project.client.profile.street,
          street_number: @donation.project.client.profile.street_number,
          zipcode: @donation.project.client.profile.zipcode
        }
      },
      items: [
        {
          id: @donation.project_id.to_s,
          title: @donation.project.title,
          unit_price: (@donation.price_paid*100).to_i,
          quantity: 1,
          tangible: false
        }
      ],
      split_rules:[
        {
          liable: true,
          charge_processing_fee: true,
          percentage: "100",
          charge_remainder_fee: true,
          recipient_id: @donation.project.client.profile.recipient_id,
        }
      ]
    })
    begin
      transaction.charge
      @donation.update(transaction_id: transaction.id, status: transaction.status)
    rescue
      @donation.update(status: 'error_in_transaction')
    end
  end
end
