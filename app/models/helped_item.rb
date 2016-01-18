class HelpedItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  validates :category_id, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true, numericality: { only_integer: true }
end
