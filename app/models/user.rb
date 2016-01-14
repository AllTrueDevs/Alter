class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  ROLES = %w[admin moderator author banned]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :requests, :dependent => :destroy
  has_attached_file :avatar, default_url: "missing-avatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates :name, presence: true, length: { maximum: 30 }
  validates :role, presence: true, inclusion: { in: %w(admin moderator author banned) }
  validates :contacts, presence: true, length: { in: 3..300  }
end
