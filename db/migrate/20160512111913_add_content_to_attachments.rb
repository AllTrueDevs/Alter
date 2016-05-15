class AddContentToAttachments < ActiveRecord::Migration
  def up
    add_attachment :attachments, :content
  end

  def down
    remove_attachment :attachments, :content
  end
end
