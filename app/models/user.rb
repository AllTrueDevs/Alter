class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  ROLES = %w[admin moderator author banned]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :requests, :dependent => :destroy
  has_many :notifications, :dependent => :destroy
  has_many :helped_items, :dependent => :destroy
  has_many :decisions
  has_attached_file :avatar, default_url: 'missing-avatar.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates :name, presence: true, length: { in: 4..40 }
  validates :role, presence: true, inclusion: { in: ROLES }
  validates :phone, length:  { maximum: 15 }
  validates :skype, length:  { maximum: 32 }
  scope :search, -> (query) { where('name like ?', "%#{query}%") }
end
