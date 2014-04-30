class User < ActiveRecord::Base
  include StatsModel

  is_impressionable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :images, dependent: :destroy
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
    hashes = images.map { |img| daily_visits(img) }
    merge_hashes(hashes)
  end

  def images_visits_by_country
    hashes = images.map { |img| country_visits(img) }
    merge_hashes(hashes)
  end

  def images_visits_by_age
    hashes = images.map { |img| age_visits(img) }
    merge_hashes(hashes)
  end

  private
    def merge_hashes(hashes)
      merged = {}
      hashes.each do |hash|
        merged.merge!(hash) { |key, old, new| old + new }
      end

      merged
    end
end
