class Profile < ApplicationRecord
  belongs_to :user
  validates :department, inclusion: { in: %w(Camera Lighting Casting Talent AD Production Transport Location)}
  has_one_attached :photo
  before_destroy :purge_photo
  has_rich_text :rich_bio

  private

  def purge_photo
    photo.purge
  end
end
