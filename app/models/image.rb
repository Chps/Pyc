class Image < ActiveRecord::Base
  include StatsModel

  def self.search(query)
    where("lower(caption) like ?", "%#{query.downcase}%")
  end

  before_validation :default_values

  is_impressionable

  has_attached_file :content,
    path: ":hash.:extension",
    hash_secret: "1ae8a70b-d9af-4359-a155-ffeccb95482f",
    storage: :dropbox,
    dropbox_credentials: {
      app_key: ENV["DROPBOX_APP_KEY"],
      app_secret: ENV["DROPBOX_APP_SECRET"],
      access_token: ENV["DROPBOX_ACCESS_TOKEN"],
      access_token_secret: ENV["DROPBOX_ACCESS_TOKEN_SECRET"],
      user_id: ENV["DROPBOX_USER_ID"],
      access_type: "app_folder"
    },
    dropbox_visibility: 'public',
    dropbox_options: {},
    styles: { medium: "300x300>", thumb: "100x100>" }

  acts_as_taggable

  validates :content, attachment_presence: true
  validates_with AttachmentPresenceValidator, attributes: :content
  validates_attachment_content_type :content, content_type: ["image/jpg", "image/jpeg", "image/png"]
  validates :caption, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy

  def default_values
    self.caption ||= "My Pyc"
  end

  def visits_by_day
    daily_visits self
  end

  def visits_by_country
    country_visits self
  end

  def visits_by_age
    age_visits self
  end
end
