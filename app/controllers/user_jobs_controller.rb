class UserJobsController < ApplicationController
  def index
    # if params[:signature] == 'success'
    #   flash[:messages] = "Your contract has been signed successfully."
    # end

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
    session[:ds_user_job_to_sign] = @user_job.id

    @config = Rails.application.config

    @token_ok = check_token
    # check if the user is authenticated on Docusign
    if @token_ok
      # do crazy shit and then render the view
      # addSpecialAttributes(model)
      @envelope_ok = session[:envelope_id].present?
      @documents_ok = session[:envelope_documents].present?
      @document_options = session.fetch(:envelope_documents, {})['documents']
      @gateway_ok = @config.gateway_account_id.try(:length) > 25
      @template_ok = session[:template_id].present?
      @source_file = file_name.to_s
      @source_url = "#{@config.github_example_url}#{@source_file}"
      @documentation = "#{@config.documentation}#{eg_name}" #= Config.documentation + EgName
      @show_doc = @config.documentation
    elsif @config.quickstart == true
      redirect_to '/ds/mustAuthenticate'
    else
      # RequestItemsService.EgName = EgName
      redirect_to '/ds/mustAuthenticate'
    end

    if params[:signature] == 'success'
      @user_job.status = "Confirmed"
      @user_job.save

      applicant = @user_job.user
      all_jobs = applicant.jobs
      conflicting_jobs = all_jobs.where("(start_date < ? AND end_date > ?) OR (start_date > ? AND end_date < ?)", @user_job.job.start_date, @user_job.job.end_date, @user_job.job.start_date, @user_job.job.end_date)
      conflicting_user_jobs = conflicting_jobs.map do |job|
        # need to convert job instances into user_job instances
        # where user = applicant
        job.user_jobs.where(user: applicant).first
      end
      conflicting_user_jobs.each { |user_job| user_job.update(status: "Rejected") }
      # Other jobs where the user is the confirmed_job user, and status is applied or approved
      # if the other user jobs start after or equals to confirmed job start date,
      # and end before or equals to confirmed job end date
      # status will change to rejected (or other job taken)
      redirect_to user_jobs_path
    end
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

  def check_token(buffer_in_min = 10)
    buffer = buffer_in_min * 60
    expires_at = session[:ds_expires_at]
    remaining_duration = expires_at.nil? ? 0 : expires_at - buffer.seconds.from_now.to_i
    if expires_at.nil?
      Rails.logger.info "==> Token expiration is not available: fetching token"
    elsif remaining_duration.negative?
      Rails.logger.debug "==> Token is about to expire in #{time_in_words(remaining_duration)} at: #{Time.at(expires_at)}: fetching token"
    else
      Rails.logger.debug "==> Token is OK for #{time_in_words(remaining_duration)} at: #{Time.at(expires_at)}"
    end
    remaining_duration > 0
  end

  def file_name
    File.basename __FILE__
  end

  def time_in_words(duration)
    "#{Object.new.extend(ActionView::Helpers::DateHelper).distance_of_time_in_words(duration)}#{duration.negative? ? ' ago' : ''}"
  end

  def eg_name
    controller_name.to(4)
  end

  def user_job_params
    params.require(:user_job).permit(:status)
  end
end
