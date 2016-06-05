class Decision < ActiveRecord::Base
  include PublicActivity::Common
  include Errorable

  has_many :accepted_items, dependent: :destroy
  belongs_to :request
  belongs_to :helper,  class_name: 'User', foreign_key: 'helper_id'
  accepts_nested_attributes_for :accepted_items, allow_destroy: true,
                                :reject_if => :accepted_item_valid?
  validate :without_accepted_items?, on: :create, :if => proc { |d| d.accepted_items.empty? } # comment for db:seed
  validates :request_id, :helper_id, presence: true
  validates :status, presence: true, inclusion: { in: %w(new unaccepted) }
  validates :description, presence: true

  def self.update_helped_items!(item)
    item.decision.helper.helped_items.find_or_initialize_by(category_id: item.required_item.category_id)
  end

  def status?(status)
    [*status].include? self.status
  end


  private


  def accepted_item_valid?(attributes)
    !attributes[:required_item_id].present?
  end

  def without_accepted_items?
    errors.add(:base, 'Не обрано жодної категорії допомоги')
  end
end
