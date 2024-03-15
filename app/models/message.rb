class Message < ApplicationRecord
  # Associations
  belongs_to :user

  # Validations
  validates :content, presence: true
  validates :sent_at, presence: true

  before_create :set_sent_at

  private

  def set_sent_at
    self.sent_at ||= Time.current
  end
end
