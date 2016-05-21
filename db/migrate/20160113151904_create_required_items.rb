class CreateRequiredItems < ActiveRecord::Migration
  def change
    create_table :required_items do |t|
      t.references :request, index: true
      t.references :category, index: true

      t.timestamps null: false
    end

    add_foreign_key :required_items, :requests
    add_foreign_key :required_items, :categories
  end
end
