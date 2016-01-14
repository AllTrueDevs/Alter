class CreateAcceptedItems < ActiveRecord::Migration
  def change
    create_table :accepted_items do |t|
      t.integer :notification_id
      t.integer :required_item_id

      t.timestamps null: false
    end
  end
end
