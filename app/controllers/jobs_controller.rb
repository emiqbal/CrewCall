class JobsController < ApplicationController
  def show
  end

  def new
    @job = Job.new
    @project = Project.find(params[:project_id])
    @user = current_user
  end

  def create
    @job = Job.new(job_params)
    @job.project = Project.find(params[:project_id])
    if @job.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  private

  def job_params
    params.require(:job).permit(:description, :salary, :start_date, :end_date)
  end
end
