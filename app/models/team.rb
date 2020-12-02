class Team < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :assigns, dependent: :destroy
  has_many :users, through: :assigns, source: :user
  # accepts_nested_attributes_for :assigns

end
