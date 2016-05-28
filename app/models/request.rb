class Request < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  has_many :required_items, dependent: :destroy
  has_many :decisions, dependent: :destroy
  has_many :notifications
  has_many :posts, class_name: 'Message', dependent: :destroy
  accepts_nested_attributes_for :required_items, allow_destroy: true,
                                :reject_if => :required_item_valid?
  has_attached_file :photo, default_url: 'missing-photo.jpg'
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  validates :name, presence: true, length: { maximum: 150 }
  validates :user_id, presence: true
  validates :status, presence: true, inclusion: { in: %w(actual archived unchecked declined) }
  validate :without_required_items?, on: :create, :if => proc { |r| r.required_items.empty? }
  [:unchecked, :actual, :archived, :declined].each do |status|
    scope status, -> { where(status: status) }
  end

  def status?(request_status)
    status == request_status.to_s
  end


  private


  def required_item_valid?(attributes)
    !attributes[:category_id].present?
  end

  def without_required_items?
    errors.add(:base, 'Не обрано жодної категорії допомоги')
  end
end
