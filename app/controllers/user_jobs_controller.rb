class UserJobsController < ApplicationController
  def index
    @user_jobs = UserJob.where(user: current_user)
    @notifications = current_user.notifications.unread
  end

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
    if @user_job.save!
      notification = CommentNotification.with(comment: "Test Producer Notification.")
      notification.deliver(@user_job.job.project.user)
      redirect_to project_path(job.project)
    else
      render :new
    end
  end

  def edit
    @user_job = UserJob.find_by(job_id: params[:job_id], id: params[:id])
  end

  def update
    @user_job = UserJob.find_by(job_id: params[:job_id], id: params[:id])
    @user_job.update(user_job_params)
    if @user_job.save
      notification = CommentNotification.with(comment: "Your application status for #{@user_job.job.project.title} is now #{@user_job.status}.")
      notification.deliver(@user_job.user)
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
