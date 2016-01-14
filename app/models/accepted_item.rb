class AcceptedItem < ActiveRecord::Base
  has_one :required_item
  belongs_to :notification

  validates :required_item_id, presence: true, numericality: { only_integer: true }
  validates :notification_id, presence: true, numericality: { only_integer: true }
end
