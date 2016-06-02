class Request < ActiveRecord::Base
  include Errorable
  include PublicActivity::Common

  acts_as_votable
  belongs_to :user
  has_many :required_items, dependent: :destroy
  has_many :completed_items, -> { completed }, class_name: 'RequiredItem'
  has_many :remaining_items, -> { remaining }, class_name: 'RequiredItem'
  has_many :categories, through: :required_items
  has_many :decisions, dependent: :destroy
  has_many :posts, class_name: 'Message', dependent: :destroy
  has_many :impressions, as: :impressionable
  accepts_nested_attributes_for :required_items, allow_destroy: true,
                                :reject_if => :required_item_valid?
  has_attached_file :photo, default_url: 'missing-photo.jpg'
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  validates :name, presence: true, length: { maximum: 150 }
  validates :user_id, presence: true
  validates :status, presence: true, inclusion: { in: %w(actual archived unchecked declined) }
  validate :without_required_items?, on: :create, :if => proc { |r| r.required_items.empty? } # comment for db:seed
  [:unchecked, :actual, :archived, :declined].each do |status|
    scope status, -> { where("requests.status = ?", status) }
  end

  scope :near_with, -> (user){ joins(:user).where(users: { region: user.region }) }

  def status?(request_status)
    status == request_status.to_s
  end

  def impression_count
    impressions.size
  end

  def unique_impression_count
    impressions.group_by(&:ip_address).size
  end

  def self.counter_params(type, builder)
    counter_params = [ (type == :required_item)? :goal_count : :count ]
    counter_params << case type
                      when :required_item then builder.object.category.try(:max).blank? ? 1 : builder.object.category.max
                      when :helped_item then builder.object.required_item.remaining_count
                      when :accepted_item then 1
                      end
  end

  def update_goal!(required_item, count)
    required_item.current_count = required_item.current_count + count
    required_item.save
  end


  private


  def required_item_valid?(attributes)
    !attributes[:category_id].present?
  end

  def without_required_items?
    errors.add(:base, 'Не обрано жодної категорії допомоги')
  end
end
