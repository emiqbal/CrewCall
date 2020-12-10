class JobsController < ApplicationController

  def new
    @job = Job.new
    @project = Project.find(params[:project_id])
    @user = current_user
  end

  def create
    @job = Job.new(job_params)
    @job.project = Project.find(params[:project_id])
    @job.salary *= 100
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
