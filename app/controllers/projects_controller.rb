class ProjectsController < ApplicationController
  before_action :set_project, only: [:show]

  def index
    @q = Project.ransack(params[:q])
    @projects = @q.result.includes(:client, :category)
    @pagy, @projects = pagy(@projects, page: params[:page], items: 20)
  end

  def show
  end
  
  private

  def set_project
    @project = Project.friendly.find(params[:id])
  end
end
