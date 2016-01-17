class AcceptedItem < ActiveRecord::Base
  belongs_to :required_item
  belongs_to :decision, dependent: :destroy

  validates :required_item_id, presence: true, numericality: { only_integer: true }
  validates :decision_id, presence: true, numericality: { only_integer: true }
end
