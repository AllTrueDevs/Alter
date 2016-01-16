class ChangeColumnsDefaults < ActiveRecord::Migration
  def change
    change_column_default(:notifications, :status, 'new')
    change_column_default(:decisions, :status, 'new')
    change_column_default(:requests, :status, 'actual')
  end
end
