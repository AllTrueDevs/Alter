class AcceptedItem < ActiveRecord::Base
  belongs_to :required_item
  belongs_to :decision

  validates :required_item_id, :decision_id, presence: true, numericality: { only_integer: true }

  #TODO refactor this

  def category_name
    self.required_item.category.name
  end

end
