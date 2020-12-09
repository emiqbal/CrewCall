class Project < ApplicationRecord
  before_destroy :purge_photo
  has_one_attached :photo
  belongs_to :user
  has_many :jobs
  validates :title, presence: true, length: { maximum: 40 }
  validates :description, presence: true

  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

  def purge_photo
    photo.purge
  end
end
