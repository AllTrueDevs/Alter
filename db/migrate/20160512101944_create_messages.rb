class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :message_type
      t.text :body
      t.string :status, default: 'new'
      t.references :sender, index: true, references: :users
      t.references :receiver, index: true, references: :users
      t.references :request, index: true, references: :requests

      t.timestamps null: false
    end

    add_foreign_key :messages, :users, column: :sender_id
    add_foreign_key :messages, :users, column: :receiver_id
    add_foreign_key :messages, :requests, column: :request_id
  end
end
