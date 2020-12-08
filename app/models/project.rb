class Project < ApplicationRecord
  before_destroy :purge_photo
  has_one_attached :photo
  belongs_to :user
  validates :title, presence: true, length: { maximum: 40 }
  validates :description, presence: true

  private

  def purge_photo
    photo.purge
  end
end
