class AddCountToTables < ActiveRecord::Migration
  def change
    add_column :required_items, :goal_count, :integer
    add_column :required_items, :current_count, :integer, default: 0
    add_column :accepted_items, :count, :integer
  end
end
