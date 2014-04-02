class AddAttachmentContentToImages < ActiveRecord::Migration
  def self.up
    change_table :images do |t|
      t.attachment :content
    end
  end

  def self.down
    drop_attached_file :images, :content
  end
end
