class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
<<<<<<< HEAD
=======
  has_one :profile
>>>>>>> a19f2a1bdfbc7a6b6c46ada33d3f9e3c2f3db209
  before_destroy :purge_photo

  private

  def purge_photo
    photo.purge
  end
end
