class User < ActiveRecord::Base
  is_impressionable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :images
  has_many :comments, dependent: :destroy

  # impressions made by this user
  has_many :impressions

  # impressions on this user
  def views(options = { select: '*' })
    Impression
      .select(options[:select])
      .where( "impressionable_type = 'User' and impressionable_id = ?", id)
  end

  def views_by_day
    created_at = 'DATE(created_at)'
    views(select: created_at).group(created_at).order(created_at).count
  end
end
