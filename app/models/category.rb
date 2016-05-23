class Category < ActiveRecord::Base
  has_many :required_items
  has_many :helped_items
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :color, presence: true

  def id_with_color
    "#{id}::#{color}"
  end
end
