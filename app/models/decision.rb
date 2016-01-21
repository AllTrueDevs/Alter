class Decision < ActiveRecord::Base
  has_many :accepted_items, dependent: :destroy
  belongs_to :request
  validates :helper_id, :request_id, presence: true, numericality: { only_integer: true }
  validates :status, presence: true, inclusion: { in: %w(new unaccepted) }
  validates :description, presence: true

  def self.update_helped_items(item)
    if User.find(item.decision.helper_id).helped_items.where(category_id: item.required_item.category_id).empty?
      HelpedItem.create(category_id: item.required_item.category_id, user_id: item.decision.helper_id)
    else
      helped_item = HelpedItem.find_by_category_id(item.required_item.category_id)
      helped_item.update(count: helped_item.count + 1)
    end
  end

end
