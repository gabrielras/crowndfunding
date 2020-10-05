# README

Este é um mvp de uma plataforma de crowdfunding

Primeiro, é necessário criar um arquivo .env na raiz da aplicação.

Adicione as senguintes chaves privadas:

PAGARME_API_KEY
PAGARME_ENCRYPTION_KEY
AWS_FOG_DIRECTORY
AWS_KEY_ID
AWS_SECRET_KEY

#Caso esteja utilizando localmente, recomendo a utilização do ngrok.
Após isso, acesse o arquivo: app/services/pagarme/create_transaction_service.rb
e realize sua substituíção do seu postback_url personalizado.

Após isso:
 rails db: create
 rails db: migrate
 rails db: seed

