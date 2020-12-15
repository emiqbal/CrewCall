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

  private

  def purge_photo
    photo.purge
  end
end
