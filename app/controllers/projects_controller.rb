require 'open-uri'

class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_project, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query]
      @projects = Project.search_by_project(params[:query]).order(updated_at: :desc)
    else
      @projects = Project.all.order(updated_at: :desc)
    end
  end

  def show
    render layout: 'no-container'
  end

  def new
    if current_user.profile.nil?
      notification = CommentNotification.with(comment: "Please complete your profile first.")
      notification.deliver(current_user)
      redirect_to edit_profile_path
    else
      @project = Project.new
      @jobs = Job.where(project: @project)
    end
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    if @project.save
      if project_params[:photo].nil?
        url = "https://source.unsplash.com/720x480/?filmmaking"
        image = URI.open(url)
        @project.photo.attach(io: image, filename: "project_#{@project.id}.jpeg", content_type: 'image/jpeg')
      end
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @project.update(project_params)
    if @project.save
      if project_params[:photo].nil?
        url = "https://source.unsplash.com/720x480/?filmmaking"
        image = URI.open(url)
        @project.photo.attach(io: image, filename: "project_#{@project.id}.jpeg", content_type: 'image/jpeg')
      end
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to overview_path
  end

  def overview
    @projects = Project.where(user: current_user)
    @notifications = current_user.notifications.unread
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :photo, :start_date, :end_date, :rich_description)
  end
end
