class Image < ActiveRecord::Base
  is_impressionable
  has_attached_file :content,
    :path => ":hash.:extension",
    :hash_secret => "1ae8a70b-d9af-4359-a155-ffeccb95482f",
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
    :dropbox_options => {},
    :styles => {
        :medium => "300x300>",
        :thumb => "100x100>"
    }

  acts_as_taggable

  validates :content, :attachment_presence => true
  validates_with AttachmentPresenceValidator, :attributes => :content
  validates_attachment_content_type :content, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  belongs_to :user


  def to_jq_upload
    {
      "name" => read_attribute(:upload_file_name),
      "size" => read_attribute(:upload_file_size),
      "url" => upload.url(:original),
      "delete_url" => upload_path(self),
      "delete_type" => "DELETE"
    }
  end
end
