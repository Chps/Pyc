class Image < ActiveRecord::Base
  has_attached_file :content,
    :storage => :dropbox,
    :dropbox_credentials => {
        app_key: ENV["DROPBOX_APP_KEY"],
        app_secret: ENV["DROPBOX_APP_SECRET"],
        access_token: ENV["DROPBOX_ACCESS_TOKEN"],
        access_token_secret: ENV["DROPBOX_ACCESS_TOKEN_SECRET"],
        user_id: ENV["DROPBOX_USER_ID"],
        access_type: "app_folder"
    },
    :dropbox_visibility => 'public',
    :dropbox_options => {}

  validates :content, :attachment_presence => true
  validates_with AttachmentPresenceValidator, :attributes => :content
  validates_attachment_content_type :content, :content_type => ["image/jpg", "image/jpeg", "image/png"]

end
