class CreateAcceptedItems < ActiveRecord::Migration
  def change
    create_table :accepted_items do |t|
      t.references :decision, index: true
      t.references :required_item, index: true

      t.timestamps null: false
    end

    add_foreign_key :accepted_items, :decisions
    add_foreign_key :accepted_items, :required_items
  end
end
