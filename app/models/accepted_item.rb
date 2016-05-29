class AcceptedItem < ActiveRecord::Base
  include Errorable

  belongs_to :required_item
  belongs_to :decision
  validates :required_item_id, presence: true
  validates_numericality_of :count, greater_than: 0

  before_save do
    if has_duplicates?(:accepted_items)
      errors.add(:base, 'Обрано однакові категорії допомоги')
      false
    end
  end
end
