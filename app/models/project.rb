class Project < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :events

  # Valid statuses for projects
  enum status: { active: 'active', completed: 'completed', on_hold: 'on_hold' }

  # Validations
  validates :name, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys }
  validates :end_date, presence: true, comparison: { greater_than: :start_date }

  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= :active
  end
end
