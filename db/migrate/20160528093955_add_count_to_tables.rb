class AddCountToTables < ActiveRecord::Migration
  def change
    add_column :required_items, :count, :integer
    add_column :accepted_items, :count, :integer
  end
end
