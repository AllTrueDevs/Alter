class CreateUserTags < ActiveRecord::Migration
  def change
    create_table :user_tags do |t|
      t.string :value
      t.string :tag_type
      t.references :user, index: true

      t.timestamps null: false
    end

    add_foreign_key :user_tags, :users
  end
end
