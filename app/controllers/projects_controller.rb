class ProjectsController < ApplicationController
  def index
  end

  def show
  end

  def new
  # @producer = current_producer
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
  # @project.producer = current_producer
    @project.save!
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :photo)
  end
end
