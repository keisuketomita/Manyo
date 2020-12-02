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

  before_update :admin_change_check
  before_destroy :admin_change_check
  def admin_change_check
    target = User.find_by(id: self.id)
    if User.where(admin: true).count <= 2
      if target.admin
        throw :abort
      end
    end
  end

  has_many :labels, dependent: :destroy

  has_many :assigns, dependent: :destroy
  has_many :teams, through: :assigns, source: :team



end
