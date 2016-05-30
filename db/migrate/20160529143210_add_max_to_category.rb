class AddMaxToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :max, :integer, default: 1
  end
end
