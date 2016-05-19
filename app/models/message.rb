class Message < ActiveRecord::Base
  has_many :attachments, dependent: :destroy
  belongs_to :receiver,  class_name: 'User', foreign_key: 'receiver_id'
  belongs_to :sender,  class_name: 'User', foreign_key: 'sender_id'
  belongs_to :request
  accepts_nested_attributes_for :attachments, allow_destroy: true,
                                :reject_if => proc { |attributes| !attributes[:content].present? }

  validates :sender_id, presence: true
  validates :body, presence: true, if: proc { |m| m.attachments.empty? }
  validates :message_type, inclusion: { in: %w(private_message post) }
  validates :status, presence: true, inclusion: { in: %w(new read) }

  [:private_message, :post].each do |type|
    scope "#{type}s".to_sym, -> { where(message_type: type) }
  end

  scope :sent_by, ->(user){ where(sender: user) }
  scope :received_by, ->(user){ where(receiver: user) }
  scope :posted_on, ->(request){ posts.where(request: request) }

  def status?(message_status)
    status.include?(message_status.to_s)
  end

  def sent_by?(user)
    self.sender == user
  end

  def received_by?(user)
    self.receiver == user
  end

  def parsed_body
    result = self.body
    domains.each{ |domain| result = result.split.map{ |word| word.gsub(/.+#{domain}/) { |matched| form_link(matched) } }.join(' ') }
    result.html_safe
  end


  private


  def domains
    %w(.com .org .ru)
  end

  def form_link(expression)
    " <a href=\"http://#{expression}\">#{expression}</a>"
  end
end
