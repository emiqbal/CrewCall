class SignaturesController < ApplicationController
  def create
    minimum_buffer_min = 10
    token_ok = check_token(minimum_buffer_min)
    unless token_ok
      flash[:messages] = "Sorry, you need to reauthenticate"
      redirect_to 'ds/mustAuthenticate'
    end
    redirect_url = SignaturesService.new(session, request).call
    redirect_to redirect_url
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
