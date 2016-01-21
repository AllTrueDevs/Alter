class NotificationRefactoring < ActiveRecord::Migration
  def change
    remove_column :notifications, :body, :string
    add_column :notifications, :message_type, :integer
    add_column :notifications, :reason_user_id, :integer
    add_column :notifications, :request_id, :integer
  end
end
