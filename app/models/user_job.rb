class UserJob < ApplicationRecord
  belongs_to :job
  belongs_to :user
  validate :check_if_user_is_available

  def start_time
    self.job.start_date
  end

  def end_time
    self.job.end_date
  end

  private

  def check_if_user_is_available
    # unavailable_dates is an array of TimeWithZone ranges
    unavailable_dates = user.unavailable_dates

    # when is this job?
    job_dates = (job.start_date.to_date)..(job.end_date.to_date)

    job_dates.each do |date|
      unavailable_dates.each do |unavailable_range|
        if unavailable_range.include? date
          errors.add(:user, "is not available on #{date}")
        end
      end
    end

  end
end
#user_job.job.project.user
#user_job.user.username
