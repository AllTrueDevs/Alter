class HelpedItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  validates :category_id, :user_id, presence: true, numericality: { only_integer: true }

  #TODO refactor this

  def category_name
    self.category.name
  end
end
