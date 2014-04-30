class User < ActiveRecord::Base
  include StatsModel

  is_impressionable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :images
  has_many :comments, dependent: :destroy

  def visitors
    impressions.select(:user_id).group(:user_id)
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

  def images_visits_by_day
    hashes = []
    images.each do |img|
      hashes << daily_visits(img)
    end

    visits = {}
    hashes.each do |hash|
      visits.merge!(hash) { |key, old, new| old + new }
    end

    visits
  end
end
