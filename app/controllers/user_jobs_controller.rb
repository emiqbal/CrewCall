class UserJobsController < ApplicationController
  def new
    @user = current_user
    @job = Job.find(params[:job_id])
    @user_job = UserJob.new
  end

  def create
    job = Job.find(params[:job_id])
    @user_job = UserJob.new(status: "Applied")
    @user_job.job = job
    @user_job.user = current_user
    if @user_job.save
      redirect_to project_path(job.project)
    else
      render :new
    end
  end

  def update
  end

end
