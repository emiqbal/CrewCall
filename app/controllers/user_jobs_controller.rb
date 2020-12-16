class UserJobsController < ApplicationController
  def index
    @user_jobs = UserJob.where(user: current_user)
    @approved = @user_jobs.where(status: 'Approved')
    @applied = @user_jobs.where(status: 'Applied')
    @confirmed = @user_jobs.where(status: 'Confirmed')
    @rejected = @user_jobs.where(status: 'Rejected')
    @calendar_events = @user_jobs.where.not(status: 'Rejected')
    @notifications = current_user.notifications.unread
  end

  def show
    @user_job = UserJob.find(params[:id])
  end

  def new
    @user = current_user
    @job = Job.find(params[:job_id])
    @user_job = UserJob.new
  end

  def create
    if current_user.profile.nil?
      notification = CommentNotification.with(comment: "Please complete your profile first.")
      notification.deliver(current_user)
      redirect_to edit_profile_path

    else
      job = Job.find(params[:job_id])
      @user_job = UserJob.new(status: "Applied")
      @user_job.job = job
      @user_job.user = current_user

      if @user_job.save
        notification = CommentNotification.with(comment: "New application for #{@user_job.job.project.title}")
        notification.deliver(@user_job.job.project.user)
        redirect_to project_path(job.project)
      else
        notification = CommentNotification.with(comment: "You already have a confirmed project during these dates.")
        notification.deliver(current_user)
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
