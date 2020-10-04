class Client::GetPaymentStatusController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    return nil if params.blank?
    @donation = Order.find_by(transaction_id: params[:id])
    return nil if @donation.blank?
    return nil if [params[:current_status],'error_in_transaction' ].include? @donation.status
    if @donation.status == 'authorized'
      Pagarme::CaptureTransactionService.new(
        donation: @donation
      ).call
    else
      @donation.update(status: params[:current_status])
    end
  end

end
