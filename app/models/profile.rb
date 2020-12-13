class Profile < ApplicationRecord
  belongs_to :user
  validates :bio, presence: true
  validates :department, inclusion: { in: %w(Camera Lighting Casting Talent AD Production Transport Location)}
  has_one_attached :photo
  before_destroy :purge_photo

  private

  def purge_photo
    photo.purge
  end
end
