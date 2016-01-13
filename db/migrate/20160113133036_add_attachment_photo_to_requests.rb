class AddAttachmentPhotoToRequests < ActiveRecord::Migration
  def self.up
    change_table :requests do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :requests, :photo
  end
end
