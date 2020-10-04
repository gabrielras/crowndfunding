class ClientsController < ApplicationController
  before_action :authenticate_client!, except: [:index]

  def index
    redirect_to new_client_session_path
  end
end
  