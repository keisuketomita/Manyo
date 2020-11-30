class Label < ApplicationRecord
  validates :name, presence:true, length: {maximum: 10}, uniqueness: true

  has_many :labellings, dependent: :destroy
  has_many :tasks, through: :labellings
  belongs_to :user
end
