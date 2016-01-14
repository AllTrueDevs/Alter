class DeleteContactsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :contacts
  end
end
