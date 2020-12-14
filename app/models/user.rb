class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
  has_one :profile
  has_many :user_jobs
  has_many :jobs, through: :user_jobs
  before_destroy :purge_photo
  validates :username, format: {
    with: /\A\S+\z/,
    message: "Please choose a name that is only 1 word."
  }

  private

  def purge_photo
    photo.purge
  end
end
