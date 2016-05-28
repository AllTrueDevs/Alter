class RequiredItem < ActiveRecord::Base
  belongs_to :category
  belongs_to :request
  has_many :accepted_items
  validates :category_id, presence: true
  validates_numericality_of :count, greater_than: 0

  after_create do
    copy = self.request.required_items.find_by_category_id(self.category_id)
    unless copy == self
      copy.update(count: self.count + copy.count)
      self.destroy
    end
  end
end
