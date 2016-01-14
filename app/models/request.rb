class Request < ActiveRecord::Base
  belongs_to :user
  has_many :required_items
  has_attached_file :photo, default_url: "missing-photo.jpg"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  validates :name, presence: true, length: { maximum: 150 }
  validates :user_id, presence: true, numericality: { only_integer: true }
end
