class Decision < ActiveRecord::Base
  has_many :accepted_items, dependent: :destroy
  belongs_to :request
  belongs_to :helper,  class_name: 'User', foreign_key: 'helper_id'
  validates :helper_id, :request_id, presence: true, numericality: { only_integer: true }
  validates :status, presence: true, inclusion: { in: %w(new unaccepted) }
  validates :description, presence: true

  def self.update_helped_items!(item)
    # item.decision.helper.helped_items.find_or_initialize_by(category_id: item.required_item.category_id)
  end
end
