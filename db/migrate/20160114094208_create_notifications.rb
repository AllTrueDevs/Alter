class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :helper_id
      t.integer :request_id
      t.string :status

      t.timestamps null: false
    end
  end
end
