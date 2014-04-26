class User < ActiveRecord::Base
  is_impressionable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :images
  has_many :comments, dependent: :destroy

  def visitors
    impressions.select(:user_id).group(:user_id)
  end

  def views_by_day
    created_at = 'DATE(created_at)'
    impressions.select(created_at).group(created_at).order(created_at).count
  end
end
