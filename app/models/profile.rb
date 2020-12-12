class Profile < ApplicationRecord
  belongs_to :user
  validates :bio, presence: true
  validates :department, inclusion: { in: %w(Camera Lighting Casting Talent AD Production Transport Location)}

end
