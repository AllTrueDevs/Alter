class Attachment < ActiveRecord::Base
  belongs_to :message
  has_attached_file :content
end