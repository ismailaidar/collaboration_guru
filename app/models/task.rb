class Task < ApplicationRecord
  # Associations
  belongs_to :project
  belongs_to :user

  # Validations
  validates :title, presence: true
  validates :due_date, presence: true
  validates :status, presence: true, inclusion: { in: %w[not_started in_progress completed] }
  validates :priority, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
