class Request < ActiveRecord::Base
  belongs_to :user
  has_many :required_items, dependent: :destroy
  has_many :decisions, dependent: :destroy
  has_attached_file :photo, default_url: 'missing-photo.jpg'
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  validates :name, presence: true, length: { maximum: 150 }
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :status, presence: true, inclusion: { in: %w(actual archived) }

  def actual?
    status == 'actual'
  end

  def archived?
    status == 'archived'
  end

end
