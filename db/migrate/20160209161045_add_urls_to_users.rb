class AddUrlsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :vkontakte, :string
    add_column :users, :vkontakte_name, :string
    add_column :users, :facebook, :string
    add_column :users, :facebook_name, :string
  end
end
