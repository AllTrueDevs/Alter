class CreateRequiredItems < ActiveRecord::Migration
  def change
    create_table :required_items do |t|
      t.integer :request_id
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
