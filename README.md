# README

link do projeto: https://mvpcrowndfunding.herokuapp.com/

Este é um mvp de uma plataforma de crowdfunding.

Primeiro, é necessário criar um arquivo .env na raiz da aplicação.
Adicione as senguintes chaves privadas:

PAGARME_API_KEY

PAGARME_ENCRYPTION_KEY

AWS_FOG_DIRECTORY

AWS_KEY_ID

AWS_SECRET_KEY

#Caso esteja utilizando localmente, recomendo a utilização do ngrok.

Após isso, acesse o arquivo: app/services/pagarme/create_transaction_service.rb
e realize a substituíção do seu postback_url personalizado.

Após isso:

 rails db:create db:migrate db:seed

Caso deseje utilize, os senguintes dados fakes da Pagarme para preencher dados bancários e do cartão de crédito.

conta bancária:

bank_code: '237',
agencia: '1935',
agencia_dv: '9',
conta: '23398',
conta_dv: '9',
legal_name: 'API BANK ACCOUNT',
document_number: '26268738888'

cartão de crédito:

card_number: "4111111111111111",
card_holder_name: "Morpheus Fishburne",
card_expiration_date: "1123",
card_cvv: "123",
cpf: "30621143049",
phone_number: "11999998888"

