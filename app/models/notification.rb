class Notification < ActiveRecord::Base
  has_many :accepted_items
  validates :helper_id, presence: true, numericality: { only_integer: true }
  validates :request_id, presence: true, numericality: { only_integer: true }
  validates :status, presence: true, inclusion: { in: %w(new unaccepted) }

end
