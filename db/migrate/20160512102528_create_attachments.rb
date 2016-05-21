class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :message, index: true

      t.timestamps null: false
    end

    add_foreign_key :attachments, :messages
  end
end
