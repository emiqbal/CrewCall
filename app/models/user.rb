class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
  has_one :profile
  has_many :user_jobs
  has_many :jobs, through: :user_jobs
  validates :username, :presence => true,
              :uniqueness => true,
              :length => {
                  :maximum => 1,
                  :tokenizer => lambda {|str| str.scan(/\w+/)},
                  :too_long => "must be one word."
              }
  before_destroy :purge_photo

  private

  def purge_photo
    photo.purge
  end
end
