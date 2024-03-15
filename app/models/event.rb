class Event < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :project

  # Validations
  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :end_time, presence: true, comparison: { greater_than: :start_time }
end
