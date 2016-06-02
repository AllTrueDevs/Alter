 class Notification < ActiveRecord::Base
  include Wordable
  belongs_to :user
  belongs_to :request
  belongs_to :reason_user,  class_name: 'User', foreign_key: 'reason_user_id'
  validates :message_type, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :status, presence: true, inclusion: { in: %w(new read) }

  def message
    case self.message_type
    when 1 then "#{form_user_link(self.reason_user)} підтвердив те, що ви дійсно допомогли по запиту #{form_request_link(self.request)}."
    when 2 then "#{form_user_link(self.reason_user)} підтвердив те, що ви частково допомогли по запиту #{form_request_link(self.request)}."
    when 3 then "#{form_user_link(self.reason_user)} відхилив факт допомоги по запиту #{form_request_link(self.request)}."
    when 4 then 'Вас було заблоковано адміністрацією'
    when 5 then 'Ваш аккаунт було розблоковано.'
    when 6 then 'Вам надано права модератора.'
    when 7 then 'У вас більше немає прав модератора.'
    when 8 then "#{form_user_link(self.reason_user)} змінив запит #{form_request_link(self.request)}."
    when 9 then "#{form_user_link(self.reason_user)} закрив запит #{form_request_link(self.request)}"
    when 10 then "Запит #{form_request_link(self.request)} було опубліковано."
    when 11 then "Запит #{form_request_link(self.request)} було відхилено."
    when 12 then "#{form_user_link(self.reason_user)} залишив позитивний відгук на вашому профілі."
    when 13 then "#{form_user_link(self.reason_user)} залишив негативний відгук на вашому профілі."
    when 14 then "#{form_user_link(self.reason_user)} залишив позитивний відгук на запиті #{form_request_link(self.request)}."
    when 15 then "#{form_user_link(self.reason_user)} залишив негативний відгук на запиті #{form_request_link(self.request)}."
    else nil
    end
  end

  def status?(request_status)
    status.include?(request_status.to_s)
  end

  def self.paginated(params, pages)
    order(:status, created_at: :desc).page(params).per(pages)
  end

end
