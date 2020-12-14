class UserJob < ApplicationRecord
  belongs_to :job
  belongs_to :user

  def start_time
    self.job.start_date
  end
end
