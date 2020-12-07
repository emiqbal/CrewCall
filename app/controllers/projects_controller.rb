require 'open-uri'

class ProjectsController < ApplicationController
  def index
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
  # @producer = current_producer
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    if @project.save
      if project_params[:photo].nil?
        # query = @project.name.split(' ').join(',')
        url = "https://source.unsplash.com/720x480/?filmmaking"
        image = URI.open(url)
        @project.photo.attach(io: image, filename: "project_#{@project.id}.jpeg", content_type: 'image/jpeg')
        end
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :photo, :start_date, :end_date)
  end
end