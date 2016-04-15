class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.text :body
      t.string :status
      t.references :user

      t.timestamps null: false
    end
    add_foreign_key :notifications, :users
  end
end
