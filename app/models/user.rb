class User < ActiveRecord::Base
  include Stats

  is_impressionable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :images
  has_many :comments, dependent: :destroy

  alias_method :super_visits_by_day, :visits_by_day

  def visitors
    impressions.select(:user_id).group(:user_id)
  end

  def visits_by_day
    super_visits_by_day self
  end

  def visits_by_country
    impressions
      .joins('INNER JOIN users ON user_id = users.id')
      .select(:country)
      .where.not('users.country' => nil, 'users.country' => '')
      .group(:country)
      .count
  end

  def visits_by_age
    ages = Array.new(8) { Array.new(2) }
    ages[0][1] = impressions.joins( 'INNER JOIN users ON user_id = users.id')
      .where("users.birthdate BETWEEN ? AND ?", Date.today - 13.years-1.days, Date.today)
      .count
    ages[0][0] = "<13"
    ages[1][1] = impressions.joins( 'INNER JOIN users ON user_id = users.id')
      .where("users.birthdate BETWEEN ? AND ?", Date.today - 18.years-1.days, Date.today-13.years)
      .count
    ages[1][0] = "13-17"
    ages[2][1] = impressions.joins( 'INNER JOIN users ON user_id = users.id')
      .where("users.birthdate BETWEEN ? AND ?", Date.today - 25.years-1.days, Date.today-18.years)
      .count
    ages[2][0] = "18-24"
    ages[3][1] = impressions.joins( 'INNER JOIN users ON user_id = users.id')
      .where("users.birthdate BETWEEN ? AND ?", Date.today - 35.years-1.days, Date.today-25.years)
      .count
    ages[3][0] = "25-34"
    ages[4][1] = impressions.joins( 'INNER JOIN users ON user_id = users.id')
      .where("users.birthdate BETWEEN ? AND ?", Date.today - 45.years-1.days, Date.today-35.years)
      .count
    ages[4][0] = "35-44"
    ages[5][1] = impressions.joins( 'INNER JOIN users ON user_id = users.id')
      .where("users.birthdate BETWEEN ? AND ?", Date.today - 55.years-1.days, Date.today-45.years)
      .count
    ages[5][0] = "45-54"
    ages[6][1] = impressions.joins( 'INNER JOIN users ON user_id = users.id')
      .where("users.birthdate BETWEEN ? AND ?", Date.today - 65.years-1.days, Date.today-55.years)
      .count
    ages[6][0] = "55-64"
    ages[7][1] = impressions.joins( 'INNER JOIN users ON user_id = users.id')
      .where("users.birthdate < ?", Date.today - 65.years)
      .count
    ages[7][0] = ">65"

    ages
  end

  def age(dob)
    now = Time.now.utc.to_date
    oldness = -1
    if dob.nil?

    else
      oldness = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    end

    oldness
  end
end
