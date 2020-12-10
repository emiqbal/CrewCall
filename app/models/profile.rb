class Profile < ApplicationRecord
  belongs_to :user
<<<<<<< HEAD

  validates :bio, :department, :company_name, presence: true
  validates :department, inclusion: { in: %w(Actor Actress Cameraman Lighting_Specialist Video_Editor Script_Writer)}


=======
>>>>>>> a19f2a1bdfbc7a6b6c46ada33d3f9e3c2f3db209
end
