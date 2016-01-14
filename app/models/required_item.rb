class RequiredItem < ActiveRecord::Base
  belongs_to :category
  belongs_to :request
  belongs_to :accepted_item
  validates :category_id, presence: true, numericality: { only_integer: true }
  validates :request_id, presence: true, numericality: { only_integer: true }
end
