class Request < ActiveRecord::Base
  belongs_to :user
  has_many :required_items, dependent: :destroy
  has_many :decisions, dependent: :destroy
  has_many :notifications
  has_attached_file :photo, default_url: 'missing-photo.jpg'
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  validates :name, presence: true, length: { maximum: 150 }
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :status, presence: true, inclusion: { in: %w(actual archived) }
  scope :actual, -> { where(status: 'actual') }
  scope :archived, -> { where(status: 'archived') }

  #TODO huynya
    def actual?
      status == 'actual'
    end

    def archived?
      status == 'archived'
    end

  def status?(request_status)
    status.include?(request_status.to_s)
  end

end
