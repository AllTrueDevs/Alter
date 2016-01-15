class FixNitificationIdName < ActiveRecord::Migration
  def change
    rename_column :accepted_items, :notification_id, :decision_id
  end
end
