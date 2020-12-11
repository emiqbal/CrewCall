require 'open-uri'

class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
<<<<<<< HEAD
    @projects = Project.all
=======
    # raise
    if params[:query]
      @projects = Project.search_by_project(params[:query]).order(updated_at: :desc)
    else
      @projects = Project.all.order(updated_at: :desc)
    end
>>>>>>> a19f2a1bdfbc7a6b6c46ada33d3f9e3c2f3db209
  end

  def show
    @project = Project.find(params[:id])
    render layout: 'no-container'
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
