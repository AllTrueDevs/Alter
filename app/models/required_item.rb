class RequiredItem < ActiveRecord::Base
  belongs_to :category
  belongs_to :request
  validates :category_id, presence: true, numericality: { only_integer: true }
  validates :request_id, presence: true, numericality: { only_integer: true }
end
