class Request < ActiveRecord::Base
  belongs_to :user
  has_many :required_items
  has_attached_file :photo, default_url: "missing-photo.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
end
