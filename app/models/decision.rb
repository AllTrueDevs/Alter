class Decision < ActiveRecord::Base
  has_many :accepted_items, dependent: :destroy
  belongs_to :request
  validates :helper_id, presence: true, numericality: { only_integer: true }
  validates :request_id, presence: true, numericality: { only_integer: true }
  validates :status, presence: true, inclusion: { in: %w(new unaccepted) }
  validates :description, presence: true

end
