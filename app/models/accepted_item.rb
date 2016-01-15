class AcceptedItem < ActiveRecord::Base
  belongs_to :required_item
  belongs_to :decision

  validates :required_item_id, presence: true, numericality: { only_integer: true }
  validates :notification_id, presence: true, numericality: { only_integer: true }
end
