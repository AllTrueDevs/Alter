class CreateHelpedItems < ActiveRecord::Migration
  def change
    create_table :helped_items do |t|
      t.integer :count
      t.references :user, index: true
      t.references :category, index: true

      t.timestamps null: false
    end

    add_foreign_key :helped_items, :users
    add_foreign_key :helped_items, :categories
  end
end
