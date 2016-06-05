class AddCustomFieldToActivities < ActiveRecord::Migration
  def change
    change_table :activities do |t|
      t.string :status
    end
  end
end
