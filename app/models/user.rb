class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  ROLES = %w[admin moderator newsmaker author banned]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:vkontakte, :facebook]
  has_many :requests, :dependent => :destroy
  has_many :notifications, :dependent => :destroy
  has_many :helped_items, :dependent => :destroy
  has_many :decisions, foreign_key: 'helper_id'
  has_many :user_tags, :dependent => :destroy
  has_many :articles
  has_attached_file :avatar, default_url: 'missing-avatar.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates :name, presence: true, length: { in: 4..40 }
  validates :role, presence: true, inclusion: { in: ROLES }
  validates :phone, length:  { maximum: 15 }
  validates :skype, length:  { maximum: 32 }
  validates :current_password, presence: true, length: { in: 8..16 }
  validates :password, :password_confirmation, presence: true, length: { in: 8..16 }

  #TODO galimuy sposob poiska
  scope :search_user, -> (query) { where('name like ?', "%#{query}%") }

  after_create do
    user_tags.create(form_tags(default_tags, :news))
  end

  def role?(user_role)
    role.include?(user_role.to_s)
  end

  def with_privileges?
    role?(:admin) || role?(:moderator)
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

  def helped_items_count
    helped_items.pluck(:count).inject(0){|sum, count| sum += count }
  end

  def news_tags
    user_tags.where(tag_type: :news).order(:value)
  end

  def create_unique_tags(tags, tag_type)
    result = tags.split(',').inject([]){|array, tag| array << { value: tag, tag_type: tag_type } if user_tags.where(tag_type: tag_type).where.not(value: tag) }
    user_tags.create(result)
  end


  private


  def default_tags
    %w(Волонтери АТО Допомога Терміново)
  end

  def form_tags(tags, tag_type)
    tags.map{ |tag| { value: tag, tag_type: tag_type } }
  end
end
