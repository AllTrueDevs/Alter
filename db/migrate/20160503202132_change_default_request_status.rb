class ChangeDefaultRequestStatus < ActiveRecord::Migration
  def change
    change_column_default(:requests, :status, 'unchecked')
  end
end
