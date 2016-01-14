class Category < ActiveRecord::Base
  has_many :required_items
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates_associated :required_items
end
