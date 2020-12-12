class Profile < ApplicationRecord
  belongs_to :user
  validates :bio, presence: true
  validates :department, presence: true, unless: :is_producer?
  validates :company_name, presence: true, if: :is_producer?
  validates :department, inclusion: { in: %w(Actor Actress Cameraman Lighting_Specialist Video_Editor Script_Writer)}

  def is_producer?
    user.is_producer
  end

end
