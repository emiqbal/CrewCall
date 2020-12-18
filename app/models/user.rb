class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
  has_one :profile, dependent: :destroy
  has_many :user_jobs, dependent: :destroy
  has_many :jobs, through: :user_jobs
  has_many :projects, dependent: :destroy
  has_many :notifications, as: :recipient
  before_destroy :purge_photo
  validates :username, uniqueness: true, format: {
    with: /\A\S+\z/,
    message: "must be only one word."
  }

  def confirmed_jobs
    # returns ActiveRecord Relation of UserJob instances
    # i.e. behaves like an array of hashes
    user_jobs.where(status: "Confirmed")
  end

  def unavailable_dates
    # returns array of date ranges where user
    # already has confirmed jobs

    # confirmed_jobs_details turns confirmed_jobs
    # from array of UserJob instances
    # to array of Job instances
    confirmed_jobs_details = confirmed_jobs.map do |user_job|
      user_job.job
    end

    # confirmed_dates turns confirmed_jobs_details
    # from array of Job instances
    # to array of date ranges
    confirmed_dates = confirmed_jobs_details.map do |job|
      (job.start_date.to_date..job.end_date.to_date)
    end
  end

  private

  def purge_photo
    photo.purge
  end
end
