class UserJobsController < ApplicationController
  def new
    @user = current_user
    @job = Job.find(params[:job_id])
    @user_job = UserJob.new
  end

  def create
    user = current_user
    job = Job.find(params[:job_id])
    @user_job = UserJob.new(user_job_params)
    @user_job.status = "Applied"
    @user_job.job = job
    @user_job.user = user
    if @user_job.save
      redirect_to project_path(job.project)
    else
      render :new
    end
  end

  def update
  end

  private

  def user_job_params
    params.require(:project).permit(:status)
  end
end
