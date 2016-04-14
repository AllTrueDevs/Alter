class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name
      t.text :body
      t.string :src
      t.string :tags

      t.timestamps null: false
    end
  end
end
