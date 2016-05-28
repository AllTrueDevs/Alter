class RequiredItem < ActiveRecord::Base
  belongs_to :category
  belongs_to :request
  has_many :accepted_items
  validates :category_id, presence: true
  validates_numericality_of :goal_count, greater_than: 0

  after_create do
    copy = self.request.required_items.find_by_category_id(self.category_id)
    unless copy == self
      copy.update(goal_count: self.goal_count + copy.goal_count)
      self.destroy
    end
  end

  def progress
    (current_count.to_f / goal_count * 100).to_i
  end

  def font_color
    return '#35353f' if self.progress == 0
    "##{( self.category.color.hex > '888888'.hex ) ? '35353f' : 'fff'}"
  end
end
