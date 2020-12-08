class Project < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 40 }
  validates :description, presence: true
end
