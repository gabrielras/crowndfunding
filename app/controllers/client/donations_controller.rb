class Client::DonationsController < ClientsController  
  include DonationHelper
  before_action :set_project, only: [:new]
  
  def index
    @donations = Donation.where(client_id: current_client.id).order('created_at DESC')
    @pagy, @donations = pagy(@donations, page: params[:page], items: 6)
  end

  def new
    @donation = Donation.new
  end

  def create
    project_id = params[:paymnet_info][:project_id].to_i

    if info_error(params[:paymnet_info]).present?
      return redirect_to new_client_donation_path(project_id: project_id), alert: "#{info_error(params[:paymnet_info])}"
    end

    @donation = Donation.new(
      client_id: current_client.id,
      project_id: params[:paymnet_info][:project_id].to_i,
      comment: params[:paymnet_info][:comment],
      price_paid: params[:paymnet_info][:price].to_f,
      status: 'pending'
    )

    if @donation.save
      Pagarme::CreateTransactionService.new(
        paymnet_info: params[:paymnet_info],
        donation: @donation
      ).call
    
      if @donation.status == 'error_in_transaction'
        redirect_to new_client_donation_path(project_id: project_id), alert: 'Houve um erro e seu pedido não foi concluído!!!'
      else
        redirect_to project_path(@donation.project), notice: 'Doação realizada com sucesso.'
      end
    else
      redirect_to new_client_donation_path(project_id: project_id), alert: 'Houve um problema para salvar a sua doação'
    end
  end

  private

  def set_project
    begin
      @project = Project.find(params[:project_id].to_i)
    rescue
      redirect_to root_path, notice: 'Não existe um projeto para essa doação.'
    end
  end
end
