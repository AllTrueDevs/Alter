class AcceptedItem < ActiveRecord::Base
  belongs_to :required_item
  belongs_to :decision
  validates :required_item_id, :decision_id, presence: true
  validates_numericality_of :count, greater_than: 0
end
