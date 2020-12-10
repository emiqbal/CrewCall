class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  validates :bio, :department, :company_name, presence: true
  validates :department, inclusion: { in: %w(Actor Actress Cameraman Lighting_Specialist Video_Editor Script_Writer)}

  
end
