class UserJobsController < ApplicationController
  def index
    @user_jobs = UserJob.where(user: current_user)
  end

  def new
    @user = current_user
    @job = Job.find(params[:job_id])
    @user_job = UserJob.new
  end

  def create
    if current_user.profile.nil?
      redirect_to edit_profile_path
    else
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
  end

  def edit
    @user_job = UserJob.find_by(job_id: params[:job_id], id: params[:id])
  end

  def update
    @user_job = UserJob.find_by(job_id: params[:job_id], id: params[:id])
    @user_job.update(user_job_params)
    if @user_job.save
      redirect_to overview_path
    else
      render :edit
    end
  end

  private

  def user_job_params
    params.require(:user_job).permit(:status)
  end
end
