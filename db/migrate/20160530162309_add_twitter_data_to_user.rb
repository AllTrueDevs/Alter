class AddTwitterDataToUser < ActiveRecord::Migration
  def change
    add_column :users, :twitter, :string
    add_column :users, :twitter_name, :string
  end
end
