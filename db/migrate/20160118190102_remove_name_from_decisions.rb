class RemoveNameFromDecisions < ActiveRecord::Migration
  def change
    remove_column :decisions, :name
  end
end
