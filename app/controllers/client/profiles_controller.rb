class Client::ProfilesController < ClientsController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  
  # GET /profile/1
  # GET /profile/1.json
  def show
  end
  
  # GET /profile/new
  def new
    @profile = Client.find(current_client.id).profile
    return redirect_to edit_client_profile_path(@profile)  if @profile.present? 
    @profile = Profile.new
  end
  
  # GET /profile/1/edit
  def edit
  end
  
  # POST /profile
  # POST /profile.json
  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      begin
        response_bank = Pagarme::CreateBankAccountService.new(profile: @profile).call
      rescue
        return redirect_to new_client_profile_path, notice: 'Houve um problema para salvar o perfil.'
      end
      if response_bank.id.present?
        @profile.update(bank_id: response_bank.id)
        response_recipient = Pagarme::CreateRecipientService.new(profile: @profile).call
        if response_recipient.id.present?
          @profile.update(recipient_id: response_recipient.id)
          return redirect_to edit_client_profile_path(@profile), notice: 'Perfil salvo com sucesso.'
        end
      end
      redirect_to new_client_profile_path, notice: 'Houve um problema para salvar o perfil.'      
    else
      redirect_to new_client_profile_path, notice: 'Houve um problema para salvar o perfil.'
    end
  end
  
  # PATCH/PUT /profile/1
  # PATCH/PUT /profile/1.json
  def update
    if @profile.update_attributes(profile_params)
      begin
        response_bank = Pagarme::CreateBankAccountService.new(profile: @profile).call
      rescue
        return redirect_to new_client_profile_path, notice: 'Houve um problema para salvar o perfil.'
      end
      if response_bank.id.present?
        @profile.reload.update(bank_id: response_bank.id)
        if @profile.recipient_id.blank?
          response_recipient = Pagarme::CreateRecipientService.new(profile: @profile).call
        else
          response_recipient = Pagarme::UpdateRecipientService.new(profile: @profile).call
        end
        if response_recipient.id.present?
          @profile.reload.update(recipient_id: response_recipient.id)
          return redirect_to edit_client_profile_path(@profile), notice: 'Perfil atualizado com sucesso.'
        end
      end
      redirect_to edit_client_profile_path(@profile), notice: 'Houve um problema para salvar o perfil.'
    else
      redirect_to edit_client_profile_path(@profile), notice: 'Houve um problema para salvar o perfil.'
    end
  end
  
  private

    def set_profile
      @profile = Profile.find(params[:id])
      authorized_profile
    end

    def authorized_profile
      if current_client.id != @profile.client.id
        redirect_to new_client_profile_path, alert: 'Você não está autorizado a editar esse Perfil.'
      end
    end

    def profile_params
      params.require(:profile).permit( :state, :city, :neighborhood, :street, :street_number, :zipcode,
      :bank_code, :agency, :account, :agency_dv, :account_dv, :account_type,
      :legal_name, :document_number).merge(client_id: current_client.id)
    end
end
