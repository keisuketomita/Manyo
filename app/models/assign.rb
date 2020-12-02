class Assign < ApplicationRecord
  belongs_to :user
  belongs_to :team
  validates_presence_of :team
  validates_presence_of :user
end
