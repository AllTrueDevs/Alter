class Category < ActiveRecord::Base
  has_many :required_items
  has_many :helped_items
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :color, presence: true
  validates :max, numericality: { in: 1..1000000000 }

  def id_with_color
    "#{id}::#{color}"
  end
end
