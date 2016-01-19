class RequiredItem < ActiveRecord::Base
  belongs_to :category
  belongs_to :request
  has_many :accepted_items
  validates :category_id, :request_id, presence: true, numericality: { only_integer: true }
  validates :request_id, presence: true, numericality: { only_integer: true }

  def category_name
    self.category.name
  end
end
