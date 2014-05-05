class Image < ActiveRecord::Base
  include StatsModel

  def self.search(query)
    where("lower(caption) like ?", "%#{query.downcase}%")
  end

  before_validation :default_values

  is_impressionable

  has_attached_file :content,
    path: ":hash.:extension",
    :bucket => ENV['S3_BUCKET_NAME'],
    hash_secret: "1ae8a70b-d9af-4359-a155-ffeccb95482f",
    styles: { medium: "300x300>", thumb: "100x100>" }

  acts_as_taggable

  validates :content, attachment_presence: true
  validates_with AttachmentPresenceValidator, attributes: :content
  validates_attachment_content_type :content, content_type: ["image/jpg", "image/jpeg", "image/png"]
  validates :caption, presence: true

  belongs_to :user
  
  has_many :comments, dependent: :destroy
  has_many :ratings

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

  def average_rating
    return 0 if ratings.empty? or ratings.map{|r| r.score}.uniq == [0]
    valid_ratings = ratings.map{|r| r.score}.reject{|r| r == 0}
    valid_ratings.inject{|sum,x| sum + x } / valid_ratings.size.to_f
  end
end
