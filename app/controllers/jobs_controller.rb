class JobsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @jobs = Job.where(project: @project)
  end

  def new
    @job = Job.new
    @project = Project.find(params[:project_id])
    # create instance variables for min date and max date
    @min_date = @project.start_date
    @max_date = @project.end_date
    @user = current_user
  end

  def create
    @job = Job.new(job_params)
    @job.project = Project.find(params[:project_id])
    @job.salary *= 100
    if @job.save
      redirect_to project_path(@job.project)
    else
      @project = @job.project
      render :new
    end
  end

  def edit
    @job = Job.find(params[:id])
    @job.salary /= 100
    @project = Project.find(params[:project_id])
  end

  def update
    @job = Job.find(params[:id])
    @job.update(job_params)
    @job.salary *= 100
    if @job.save
      redirect_to project_path(@job.project)
    else
      @project = @job.project
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to project_path(@job.project)
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :salary, :start_date, :end_date, :department, :rich_description)
  end
end
