class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :info, :text
    add_column :users, :contacts, :string
  end
end
