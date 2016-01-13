class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :requests, :dependent => :destroy
  has_attached_file :avatar, default_url: "missing-avatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  ROLES = %w[admin moderator author banned]
end
