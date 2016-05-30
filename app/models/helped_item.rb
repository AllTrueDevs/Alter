class HelpedItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  validates :category_id, :user_id, presence: true
  validates_numericality_of :count, greater_than: 0
end
