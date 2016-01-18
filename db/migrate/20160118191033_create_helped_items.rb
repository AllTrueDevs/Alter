class CreateHelpedItems < ActiveRecord::Migration
  def change
    create_table :helped_items do |t|
      t.integer :count, default: 0
      t.integer :user_id
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
