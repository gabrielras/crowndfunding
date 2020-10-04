module DonationHelper
  include Pagy::Frontend

  def info_error(payment_info)
    if [3,4].exclude? payment_info[:card_cvv].length
      return 'O número de CVV está errado.' 
    end

    if [10,11].exclude? payment_info[:phone_number].gsub(/[^0-9]/, '').length
      return 'O número do celular está errado.'
    end

    if !CPF.valid?(payment_info[:cpf_number])
      return 'O CPF não é válido.'
    end

    if [14,15,16].exclude? payment_info[:card_number].gsub(/[^0-9]/, '').length
      return 'O formato do cartão de crédito está errado.'
    end

    if [4].exclude? payment_info[:card_expiration_date].gsub(/[^0-9]/, '').length
      return 'O formato da data de expiração está errado.'
    end

    if payment_info[:price].to_f <= 1
      return 'O valor pago deve ser maior que 1 real.'
    end
  end
end
