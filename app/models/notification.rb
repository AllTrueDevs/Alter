class Notification < ActiveRecord::Base
  belongs_to :user
  validates :body, presence: true, length: { in: 5..400 }
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :status, presence: true, inclusion: { in: %w(new read) }
end
