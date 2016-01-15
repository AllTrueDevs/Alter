class RenameNotificationsToDecisions < ActiveRecord::Migration
  def change
    rename_table :notifications, :decisions
  end
end
