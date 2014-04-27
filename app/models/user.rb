class User < ActiveRecord::Base
  is_impressionable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :images
  has_many :comments, dependent: :destroy

  def visitors
    impressions.select(:user_id).group(:user_id)
  end

  def visits_by_day
    created_at = 'DATE(created_at)'
    impressions.select(created_at).group(created_at).order(created_at).count
  end

  def visits_by_country
    impressions.joins( 'INNER JOIN users ON user_id = users.id')
      .select(:country)
      .where('users.country IS NOT NULL')
      .group(:country)
      .count
  end
end
