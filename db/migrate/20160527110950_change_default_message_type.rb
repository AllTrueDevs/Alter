class ChangeDefaultMessageType < ActiveRecord::Migration
  def change
    change_column_default :messages, :message_type, :private_message
  end
end
