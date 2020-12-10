class Project < ApplicationRecord
  before_destroy :purge_photo
  has_one_attached :photo
  belongs_to :user
  has_many :jobs
  validates :title, presence: true, length: { maximum: 40 }
  validates :description, presence: true

  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date

<<<<<<< HEAD
=======
  include PgSearch::Model
  pg_search_scope :search_by_project,
  against: [:title, :description],
  using: {
    tsearch: { prefix: true }
  }

>>>>>>> a19f2a1bdfbc7a6b6c46ada33d3f9e3c2f3db209
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
