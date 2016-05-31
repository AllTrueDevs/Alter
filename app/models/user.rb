class User < ActiveRecord::Base
  ROLES = %w[admin moderator newsmaker author banned]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:vkontakte, :facebook, :twitter]
  acts_as_voter
  acts_as_votable
  has_many :requests, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :helped_items, dependent: :destroy
  has_many :decisions, foreign_key: 'helper_id', dependent: :destroy
  has_many :user_tags, :dependent => :destroy
  has_many :articles, dependent: :destroy
  has_many :received_messages, -> { where(access: %w(both receiver), message_type: 'private_message') },
              class_name: 'Message', foreign_key: 'receiver_id', dependent: :destroy
  has_many :sent_messages, -> { where(access: %w(both sender), message_type: 'private_message') },
              class_name: 'Message', foreign_key: 'sender_id', dependent: :destroy
  has_attached_file :avatar, default_url: 'missing-avatar.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates :name, presence: true, length: { in: 2..40 }
  validates :role, presence: true, inclusion: { in: ROLES }
  validates :phone, length:  { maximum: 20 }
  validates :skype, length:  { maximum: 32 }

  scope :search, -> (query) { where("LOWER(name) LIKE LOWER('%#{query}%')") }

  after_create do
    user_tags.create(form_tags(default_tags, :news))
  end

  def role?(user_role)
    role == user_role.to_s
  end

  def with_privileges?
    role?(:admin) || role?(:moderator)
  end

  def social_oauth!(type, access_token)
    name = access_token.info.name
    url = case type
          when :vkontakte then access_token.info.urls.Vkontakte
          when :facebook then "https://facebook.com/#{access_token.extra.raw_info.id}"
          when :twitter then access_token.info.urls.Twitter
          end
    self.update("#{type}".to_sym => url, "#{type}_name".to_sym => name)
  end

  def self.find_for_social_oauth(type, access_token)
    require 'open-uri'
    url = case type
          when :vkontakte then access_token.info.urls.Vkontakte
          when :facebook then "https://facebook.com/#{access_token.extra.raw_info.id}"
          when :twitter then access_token.info.urls.Twitter
          end
    user = User.find_by_social_sign_up_url(url)
    return user if user.present?

    name = access_token.info.name
    case type
    when :vkontakte
      avatar = open(access_token.extra.raw_info.photo_400_orig)
      email = "#{access_token.extra.raw_info.screen_name}@vk.com"
    when :facebook
      avatar = open("#{access_token.info.image.gsub('http', 'https')}/?type=large")
      email = "#{name.downcase.gsub(' ', '.')}_#{access_token.extra.raw_info.id}@facebook.com"
    when :twitter
      avatar = open(access_token.info.image.gsub!('_normal',''))
      email = "#{access_token.info.nickname.downcase}@twitter.com"
    end
    user = User.new(social_sign_up_url: url, "#{type}".to_sym => url, name: name, "#{type}_name".to_sym => name, avatar: avatar, email: email, password: Devise.friendly_token[0,20])
    user.skip_confirmation!
    user.save
    user
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

  def dialog(user)
    received_messages.sent_by(user).union(sent_messages.received_by(user)).order(created_at: :desc)
  end

  def messages
    received_messages.union(sent_messages)
  end

  def mailbox_empty?
    received_messages.private_messages.empty? && sent_messages.private_messages.empty?
  end

  def activity
    PublicActivity::Activity.all.where(owner_id: id, owner_type: 'User')
  end

  def counters(type)
    case(type)
    when :decisions then Decision.where(status: 'new', request: self.requests).size
    when :notifications then self.notifications.where(status: 'new').size
    when :messages then  self.received_messages.where(status: 'new').size
    when :unchecked then Request.unchecked.size
    else nil
    end
  end

  def update_helped_item!(category, count)
    found_item = self.helped_items.find_or_initialize_by(category: category)
    found_item.count = found_item.count.to_i + count
    found_item.save
  end

  def social_sign_up_type
    return nil if self.social_sign_up_url.nil?
    case self.social_sign_up_url
    when self.vkontakte then :vkontakte
    when self.facebook then :facebook
    when self.twitter then :twitter
    else nil
    end
  end


  private


  def default_tags
    %w(Волонтери АТО Допомога Терміново)
  end

  def form_tags(tags, tag_type)
    tags.map{ |tag| { value: tag, tag_type: tag_type } }
  end
end
