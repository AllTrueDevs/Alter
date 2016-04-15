class CreateUserTags < ActiveRecord::Migration
  def change
    create_table :user_tags do |t|
      t.string :value
      t.string :tag_type
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
