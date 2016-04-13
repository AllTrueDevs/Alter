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
            when 1 then "#{form_user_link(User.find(self.reason_user_id))} підтвердив те, що ви дійсно допомогли по запиту #{form_request_link(Request.find(self.request_id))}."
            when 2 then "#{form_user_link(User.find(self.reason_user_id))} підтвердив те, що ви частково допомогли по запиту #{form_request_link(Request.find(self.request_id))}."
            when 3 then "#{form_user_link(User.find(self.reason_user_id))} відхилив факт допомоги по запиту #{form_request_link(Request.find(self.request_id))}."
            when 4 then 'Вас було заблоковано адміністрацією'
            when 5 then 'Ваш аккаунт було розблоковано.'
            when 6 then 'Вам надано права модератора.'
            when 7 then 'У вас більше немає прав модератора.'
            when 8 then "#{form_user_link(User.find(self.reason_user_id))} змінив запит про допомогу #{form_request_link(Request.find(self.request_id))}."
            when 9 then "#{form_user_link(User.find(self.reason_user_id))} закрив запит про допомогу #{form_request_link(Request.find(self.request_id))}."
            else null
          end
  end

  def self.paginated(params, pages)
    order(:status, :created_at => :desc).page(params).per(pages)
  end

end
