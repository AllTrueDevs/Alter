class RequiredItem < ActiveRecord::Base
  include Errorable

  belongs_to :category
  belongs_to :request
  has_many :accepted_items, dependent: :destroy
  validates :category_id, presence: true
  validates_numericality_of :goal_count, greater_than: 0

  before_save do
    if has_duplicates?(:required_items)
      errors.add(:base, 'Обрано однакові категорії допомоги')
      false
    end
  end

  after_save do
    self.request.update(status: 'archived') unless self.request.required_items.any?{ |item| !item.completed? }
  end

  def self.completed
    where('goal_count <= current_count')
  end

  def self.remaining
    where('goal_count > current_count')
  end

  def completed?
    self.current_count >= self.goal_count
  end

  def progress
    value = (current_count.to_f / goal_count * 100).to_i
    (value <= 100)? value : 100
  end

  def font_color
    return '#35353f' if self.progress == 0
    rgb = self.category.color.chars.sum{ |symb| symb.hex - 7 }
    "##{( rgb > 0 ) ? '35353f' : 'fff'}"
  end

  def remaining_count
    self.goal_count - self.current_count
  end
end
