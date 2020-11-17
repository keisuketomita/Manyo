class Task < ApplicationRecord
  validates :name, presence:true, length: {maximum: 30}
  validates :detail, presence:true, length: {maximum: 300}
  validates :dead_line, presence:true
  validates :status, presence:true
  validates :priority, presence:true

  scope :priority_desc, -> { order(priority: :desc) }
  scope :dead_line_desc, -> { order(dead_line: :desc) }
  scope :created_at_desc, -> { order(created_at: :desc) }
  scope :name_like, -> (name) { where('tasks.name LIKE ?', "%#{name}%") if name.present? }
  scope :status_is, -> (status) { where(status: status) if status.present? }
  scope :label_is, -> (labels) { joins(:labels).where(labels: { id: labels }) if labels.present? }

  enum priority: { 低: 0, 中: 1, 高: 2 }

  belongs_to :user
  validates_presence_of :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings

end
