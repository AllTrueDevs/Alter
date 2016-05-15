class NotificationRefactoring < ActiveRecord::Migration
  def change
    remove_column :notifications, :body, :string

    add_column :notifications, :message_type, :integer

    add_reference :notifications, :request, index: true
    add_foreign_key :notifications, :requests

    add_column :notifications, :reason_user_id, :integer
    add_index :notifications, :reason_user_id
    add_foreign_key :notifications, :users, column: :reason_user_id
  end
end
