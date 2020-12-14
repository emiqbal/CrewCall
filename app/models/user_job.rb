class UserJob < ApplicationRecord
  belongs_to :job
  belongs_to :user

  def start_time
    self.job.start_date
  end

  def end_time
    self.job.end_date
  end
end
#user_job.job.project.user
#user_job.user.username
