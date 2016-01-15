class RequiredItem < ActiveRecord::Base
  belongs_to :category
  belongs_to :request
  has_one :accepted_item
  validates :category_id, presence: true, numericality: { only_integer: true }
  validates :request_id, presence: true, numericality: { only_integer: true }

  def category_name
    self.category.name
  end
end
