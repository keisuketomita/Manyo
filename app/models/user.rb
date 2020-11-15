class User < ApplicationRecord
  validates :name, presence:true, length: {maximum: 30}
  validates :email, presence:true, length: {maximum:255}, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence:true, length: { minimum: 6 }, on: :create
  has_many :tasks, dependent: :destroy
  accepts_nested_attributes_for :tasks, allow_destroy: true

  scope :created_at_desc, -> { order(created_at: :desc) }
end
