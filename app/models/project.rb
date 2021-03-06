class Project < ApplicationRecord
  before_destroy :purge_photo
  before_create :assign_color
  has_one_attached :photo
  has_rich_text :rich_description
  belongs_to :user
  has_many :jobs, dependent: :destroy
  validates :title, presence: true, length: { maximum: 70 }

  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date

  include PgSearch::Model
  pg_search_scope :search_by_project,
  against: [:title, :description],
  using: {
    tsearch: { prefix: true }
  }

  def start_time
    self.start_date
  end

  def end_time
    self.end_date
  end

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

  def assign_color
    if user.projects.empty?
      self.color = 1
    else
      self.color = (self.user.projects.order(:created_at).last.color % 4) + 1
    end
  end
end
