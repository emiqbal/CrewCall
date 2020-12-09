class JobsController < ApplicationController
  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
    @project = Project.find(params[:project_id])
    @user = current_user
  end

  def create
    raise
    @job = Job.new(job_params)
    @job.project = Project.find(params[:project_id])
    if @job.save
      redirect_to project_path(@job.project)
    else
      render :new
    end
  end

  private

  def job_params
    params.require(:job).permit(:description, :salary, :start_date, :end_date)
  end
end
