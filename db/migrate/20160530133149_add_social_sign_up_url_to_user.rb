class AddSocialSignUpUrlToUser < ActiveRecord::Migration
  def change
    add_column :users, :social_sign_up_url, :string
  end
end
