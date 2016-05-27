 class Notification < ActiveRecord::Base
  include NotificationsHelper
  belongs_to :user
  belongs_to :request
  belongs_to :reason_user,  class_name: 'User', foreign_key: 'reason_user_id'
  validates :message_type, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :status, presence: true, inclusion: { in: %w(new read) }

  def message
    msg = case self.message_type
          when 1 then "#{form_user_link(User.find(self.reason_user_id))} підтвердив те, що ви дійсно допомогли по <a #{form_request_link(Request.find(self.request_id))}>запиту</a>"
          when 2 then "#{form_user_link(User.find(self.reason_user_id))} підтвердив те, що ви частково допомогли по <a #{form_request_link(Request.find(self.request_id))}>запиту</a>."
          when 3 then "#{form_user_link(User.find(self.reason_user_id))} відхилив факт допомоги по <a #{form_request_link(Request.find(self.request_id))}>запиту</a>."
          when 4 then 'Вас було заблоковано адміністрацією'
          when 5 then 'Ваш аккаунт було розблоковано.'
          when 6 then 'Вам надано права модератора.'
          when 7 then 'У вас більше немає прав модератора.'
          when 8 then "#{form_user_link(User.find(self.reason_user_id))} змінив <a #{form_request_link(Request.find(self.request_id))}>запит</a> про допомогу."
          when 9 then "#{form_user_link(User.find(self.reason_user_id))} закрив <a #{form_request_link(Request.find(self.request_id))}>запит</a> про допомогу."
          when 10 then "Ваш <a #{form_request_link(Request.find(self.request_id))}>запит</a> було опубліковано."
          when 11 then "Ваш <a #{form_request_link(Request.find(self.request_id))}>запит</a> було відхилено."
          else null
          end
  end

  def status?(request_status)
    status.include?(request_status.to_s)
  end

  def self.paginated(params, pages)
    order(:status, created_at: :desc).page(params).per(pages)
  end

end
