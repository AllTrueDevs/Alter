class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  ROLES = %w[admin moderator author banned]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:vkontakte, :facebook]
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

  def banned?
    role == 'banned'
  end

  def moderator?
    role == 'moderator'
  end

  def admin?
    role == 'admin'
  end

  def vkontakte_oauth!(access_token)
    url = access_token.info.urls.Vkontakte
    name = "#{access_token.extra.raw_info.first_name} #{access_token.extra.raw_info.last_name}"
    update(vkontakte: url, vkontakte_name: name)
  end

  def facebook_oauth!(access_token)
    url = access_token.extra.raw_info.id
    name = access_token.extra.raw_info.name
    update(facebook: "https://facebook.com/#{url}", facebook_name: name)
  end

end
