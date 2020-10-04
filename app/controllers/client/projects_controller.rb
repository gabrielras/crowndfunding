class Client::ProjectsController < ClientsController
  include EnabledClient
  before_action :set_project, only: [:edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @q = Project.search(params[:q])
    @projects = @q.result.where(:client_id => current_client.id)
                          .order('created_at DESC')
    @pagy, @projects = pagy(@projects, page: params[:page], items: 20)
  end
  
  # GET /projects/new
  def new
    return redirect_to new_client_profile_path, notice: 'Conclua seu Perfil.' unless profile_is_complete?(current_client)
    @project = current_client.projects.build
  end
  
  # GET /projects/1/edit
  def edit
  end
  
  # POST /projects
  # POST /projects.json
  def create
    @project = current_client.projects.build(project_params)
    if @project.save
      redirect_to edit_client_project_path(@project), notice: 'Projeto criado com sucesso.'
    else
      render :new, alert: 'Projeto não foi criado, tente novamente.'
    end
  end
  
  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    if @project.update_attributes(visibility: project_params[:visibility], quantity: project_params[:quantity])
      redirect_to edit_client_project_path(@project), notice: 'Projeto atualizado com sucesso.'
    else
      render edit_client_project_path(@project), alert: 'Projeto não atualizado.'
    end
  end

  def destroy
    @project.destroy
    redirect_to client_project_path, notice: 'Seu projeto foi excluído.'
  end
  
  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.friendly.find(params[:id])
    authorized_project
  end

  def authorized_project
    if current_client.id != @project.client.id
      redirect_to client_projects_path, alert: 'Você não está autorizado a editar esse projeto.'
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params 
    params.require(:project).permit(:category_id, :title, :price, :description,
      :image, :end_time, :start_time)
  end
end
